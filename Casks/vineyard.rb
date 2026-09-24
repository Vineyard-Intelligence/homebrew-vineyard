cask "vineyard" do
  version "0.3.9"

  # VERSION, TAGGED URL AND CHECKSUM, all three, and release.sh writes all three.
  #
  # This file spent a while pinning no checksum, for a reason that was true then:
  # the url pointed at `releases/latest/download` and the release was overwritten
  # in place under one version, so a pinned hash described one build and was wrong
  # for every tap that had not pulled in the same breath. `brew reinstall` failed
  # with "Cask reports different checksum" against a tap two commits behind.
  #
  # The note here called the alternative — bump the version per release and pin
  # the url to that tag — and rejected it, because the release was deliberately
  # overwritten. That premise is gone: overwriting one tag produced a DRAFT
  # release that `releases/latest` silently skipped, so every installer served an
  # eleven-day-old build while each release reported success. Releases are now
  # versioned and never deleted, which makes the bytes behind the url below
  # immutable — so the hash can be pinned, and `brew upgrade` has a version to
  # compare. Both are things the moving target cost.
  #
  # Do not hand-edit these three lines; release.sh rewrites them by keyword at the
  # start of the line, and verifies afterwards that the cask names the bytes it
  # just published.
  #
  # (brew style flags the release-asset URL as "use tarballs" — that rule is
  # for source distributions; a binary app ships as a release asset.)
  sha256 "ada992f3bdcb2d6705307564b848b3a7ec609d140ab3ef5fee58b06a88a5c155"
  url "https://github.com/whatabeautifulmemory/vineyard-website/releases/download/v0.3.9/Vineyard-mac-arm64.zip"
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
