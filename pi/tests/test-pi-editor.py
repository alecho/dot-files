# Run: python ~/dotfiles/pi/tests/test-pi-editor.py
import json
import os
from pathlib import Path
import subprocess
import tempfile

launcher = Path(__file__).resolve().parents[1] / ".local/bin/pi-editor"
with tempfile.TemporaryDirectory() as directory:
    root = Path(directory)
    log = root / "calls"
    for name in ("nvim", "zellij"):
        executable = root / name
        executable.write_text(
            "#!/usr/bin/python\n"
            "import json, os, sys\n"
            "from pathlib import Path\n"
            "with open(os.environ['TEST_LOG'], 'a') as log:\n"
            "    log.write(json.dumps([Path(sys.argv[0]).name, *sys.argv[1:]]) + '\\n')\n"
            "if sys.argv[1:3] == ['action', 'list-panes']:\n"
            "    print(json.dumps([{'id': 1, 'is_plugin': True}, json.loads(os.environ['TEST_PARENT'])]))\n"
            "sys.exit(int(os.environ['TEST_STATUS']) if sys.argv[1:2] != ['action'] else 0)\n"
        )
        executable.chmod(0o755)
    env = dict(os.environ, PATH=f"{root}:/usr/bin", TEST_LOG=str(log))
    for geometry in (None, (1, 2, 80, 30), (172, 22, 169, 74), (1, 2, 40, 10)):
        parent = dict(id=1, is_plugin=False)
        if geometry:
            parent.update(zip(("pane_content_x", "pane_content_y", "pane_content_columns", "pane_content_rows"), geometry))
        for status in (0, 7):
            env.update(ZELLIJ="0" if geometry else "", ZELLIJ_PANE_ID="1", TEST_STATUS=str(status), TEST_PARENT=json.dumps(parent))
            log.write_text("")
            result = subprocess.run([str(launcher), "/tmp/prompt with spaces.md"], env=env)
            assert result.returncode == status
            calls = [json.loads(line) for line in log.read_text().splitlines()]
            if geometry:
                assert calls[0] == ["zellij", "action", "list-panes", "--geometry", "--json"]
                run = calls[1]
                assert run[:2] == ["zellij", "run"]
                assert "--blocking" in run and "--close-on-exit" in run
                assert run[-3:] == ["--", "nvim", "/tmp/prompt with spaces.md"]
                x, y, columns, rows = geometry
                expected = dict(width=columns, height=min(15, rows), x=x, y=y + max(0, rows-15))
                for key, value in expected.items():
                    assert run[run.index("--" + key) + 1] == str(value)
                assert calls[2:] == [["zellij", "action", "focus-pane-id", "1"]]
            else:
                assert calls == [["nvim", "/tmp/prompt with spaces.md"]]
print("PASS: parent-relative size and position, exit status, focus, quoting, and fallback")
