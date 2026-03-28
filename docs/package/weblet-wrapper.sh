#!/bin/sh
# Launch the app via macOS Launch Services to avoid terminal hang
# We use the full path to the /Applications folder where Homebrew installs casks
exec open -a "/Applications/weblet.app" --args "$@"