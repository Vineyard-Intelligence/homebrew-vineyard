cask "vineyard" do
  version "0.1.0"
  sha256 "4a344c4e56c2529971f997633b3cf2f7cd5cb70307a52ebf7c06078c77102ff8"

  # Version-agnostic: releases always upload the same Vineyard-mac-arm64.zip,
  # so latest/download serves the newest build. `version` above still drives
  # brew's upgrade detection; bump it and this sha256 on each release.
  # (brew style flags the release-asset URL as "use tarballs" — that rule is
  # for source distributions; a binary app ships as a release asset.)
  url "https://github.com/whatabeautifulmemory/vineyard-website/releases/latest/download/Vineyard-mac-arm64.zip"
  name "Vineyard"
  desc "CTI/OSINT graph analysis platform"
  homepage "https://vineyard.run/"

  depends_on :macos

  app "Vineyard.app"

  # Ad-hoc signed (no Developer ID): Homebrew 6 removed both the
  # no_quarantine DSL and the --no-quarantine option, and the download cache
  # quarantine still propagates to the installed app via the extraction step.
  # Strip it at install time so the first launch skips Gatekeeper's "cannot
  # verify" dialog. (Removable once the app is Developer ID-signed.)
  postflight do
    system_command "xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/Vineyard.app"]
  end

  zap trash: [
    "~/Library/Application Support/run.vineyard.desktop",
    "~/Library/Application Support/Vineyard",
    "~/Library/Caches/run.vineyard.desktop",
    "~/Library/Preferences/run.vineyard.desktop.plist",
    "~/Library/Saved Application State/run.vineyard.desktop.savedState",
  ]
end
