# Runs for ALL zsh invocations (login, non-login, interactive, scripts).
# Must be set before any `mise activate` so mise reads the right config,
# including non-login shells like zellij-resumed panes.
export MISE_DEFAULT_CONFIG_FILENAME="mise.local.toml"
