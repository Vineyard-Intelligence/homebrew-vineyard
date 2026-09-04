cask "vineyard" do
  version "0.1.0"

  # NO CHECKSUM, because there is nothing stable to check one against.
  #
  # The url below points at `releases/latest/download`, which by design serves
  # whatever was built most recently — the release is overwritten in place under
  # one version rather than tagged anew each time. A pinned sha256 describes ONE
  # build, so every rebuild made this file wrong for anyone who had not pulled
  # the tap in the same breath. That is not hypothetical: `brew reinstall` failed
  # with "Cask reports different checksum" against a tap two commits behind, and
  # it would have done so after every release.
  #
  # Two ways out. Bump `version` per release and pin the url to that tag, which
  # restores both upgrade detection and integrity — rejected, because the release
  # is deliberately overwritten rather than versioned. Or stop pinning a hash to
  # a moving target, which is this. The trade is real and worth naming: download
  # verification now rests on HTTPS and GitHub serving the right asset, with no
  # second opinion from this file.
  #
  # `version` stays for identity and the Caskroom path. It does NOT drive upgrade
  # detection any more — it never really did, since it does not change — so a new
  # build is picked up by `brew reinstall --cask vineyard`, not `brew upgrade`.
  #
  # (brew style flags the release-asset URL as "use tarballs" — that rule is
  # for source distributions; a binary app ships as a release asset.)
  sha256 :no_check
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
