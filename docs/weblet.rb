cask "weblet" do
  version "1.0"
  sha256 "d19ec3578874191c718bff79bf7788ebebb5a8a88baaa3ab52ddc1bed20bee96"

  url "https://github.com/fellowgeek/weblet/releases/download/v#{version}/weblet.dmg"
  name "weblet"
  desc "A lightweight macOS web view application that can be launched and configured via command-line arguments."
  homepage "https://github.com/fellowgeek/weblet"

  app "weblet.app"

  # Creates a shim script so 'weblet' works in the terminal
  binary "weblet-wrapper", target: "weblet"

  # Create and permission the wrapper script
  preflight do
    wrapper_script = "#{staged_path}/weblet-wrapper"

    File.write(wrapper_script, <<~SH)
      #!/bin/sh
      # Launch the app via macOS Launch Services to avoid terminal hang
      exec open -a "#{appdir}/weblet.app" --args "$@"
    SH

    FileUtils.chmod("+x", wrapper_script)
  end

  zap trash: [
    "~/Library/Application Support/weblet",
    "~/Library/Preferences/com.weblet.fellowgeek.enClose.plist",
    "~/Library/Saved Application State/com.weblet.fellowgeek.enClose.savedState",
  ]
end