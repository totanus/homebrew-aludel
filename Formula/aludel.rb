class Aludel < Formula
  desc "Convert text or URLs to a two-voice podcast episode from the command line"
  homepage "https://aludel.matteobalocco.it/cli.html"
  url "https://github.com/totanus/aludel-releases/releases/download/cli-v0.1.1/aludel-cli-macos-aarch64-0.1.1.zip"
  sha256 "9eb57a0c7b8d9c01a383ee9775f3567878a09e956db460e7ff0f3c5c8fc97b2a"
  license :cannot_represent
  version "0.1.1"

  depends_on arch: :arm64
  depends_on macos: :monterey

  # Piper + ffmpeg (bundled x86_64/arm64 binaries), the piper dylibs, and
  # piper/espeak-ng-data/ all need to sit in the same directory as the real
  # `aludel` binary — aludel-cli's sidecar::find_bundled_binary resolves them
  # relative to `std::env::current_exe()`'s directory, and PiperProvider
  # falls back to that same directory for its dylibs/espeak-ng-data when no
  # explicit support_dir is set. libexec (not bin) keeps that layout intact;
  # only a symlink to the real binary goes on PATH.
  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"aludel"
  end

  test do
    assert_match "aludel #{version}", shell_output("#{bin}/aludel --version")
  end
end
