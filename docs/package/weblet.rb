cask "weblet" do
  version "1.2"
  sha256 "aed213e214fda37b164b6e94018c9a7b17dca5ede8dbf97a49c26608179a9a84"

  url "https://github.com/fellowgeek/weblet/releases/download/v#{version}/weblet.dmg"
  name "weblet"
  desc "A lightweight macOS web view application that can be launched and configured via command-line arguments."
  homepage "https://github.com/fellowgeek/weblet"

  depends_on macos: ">= :sonoma"
  app "weblet.app"

  # Creates a shim script so 'weblet' works in the terminal
  binary "weblet-wrapper", target: "weblet"

  # Create and permission the wrapper script
  preflight do
    wrapper_script = "#{staged_path}/weblet-wrapper"

    File.write(wrapper_script, <<~SH)
      #!/bin/sh
      # Launch the app via macOS Launch Services to avoid terminal hang
      exec open -n -a "#{appdir}/weblet.app" --args "$@"
    SH

    FileUtils.chmod("+x", wrapper_script)
  end

  zap trash: [
    "~/Library/Application Support/weblet",
    "~/Library/Preferences/com.weblet.fellowgeek.enClose.plist",
    "~/Library/Saved Application State/com.weblet.fellowgeek.enClose.savedState",
  ]
end