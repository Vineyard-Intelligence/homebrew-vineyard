cask "vineyard" do
  version "0.1.0"
  sha256 "6bc6a73ee624acb8e115c08526d5eb756cf276a390d1ff0fc86ef801debfbc07"

  url "https://github.com/whatabeautifulmemory/vineyard-website/releases/download/v#{version}/Vineyard-#{version}-mac-arm64.zip"
  name "Vineyard"
  desc "CTI/OSINT graph analysis platform"
  homepage "https://vineyard.run/"

  depends_on :macos

  app "Vineyard.app"

  # Ad-hoc signed (no Developer ID): keep quarantine OFF at install so the
  # first launch does not hit Gatekeeper's "cannot verify" dialog.
  no_quarantine true

  zap trash: [
    "~/Library/Application Support/run.vineyard.desktop",
    "~/Library/Application Support/Vineyard",
    "~/Library/Caches/run.vineyard.desktop",
    "~/Library/Preferences/run.vineyard.desktop.plist",
    "~/Library/Saved Application State/run.vineyard.desktop.savedState",
  ]
end
