cask "vineyard" do
  version "0.1.0"
  sha256 "20240e725d042a406246de9bef9834dd281051719e7d5f7258cf2557beafe308"

  url "https://github.com/whatabeautifulmemory/vineyard-website/releases/download/v#{version}/Vineyard-#{version}-arm64.zip"
  name "Vineyard"
  desc "CTI/OSINT graph analysis platform"
  homepage "https://vineyard.run/"

  depends_on :macos

  app "Vineyard.app"

  zap trash: [
    "~/Library/Application Support/run.vineyard.desktop",
    "~/Library/Application Support/Vineyard",
    "~/Library/Caches/run.vineyard.desktop",
    "~/Library/Preferences/run.vineyard.desktop.plist",
    "~/Library/Saved Application State/run.vineyard.desktop.savedState",
  ]
end
