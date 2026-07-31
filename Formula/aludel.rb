class Aludel < Formula
  desc "Convert text or URLs to a two-voice podcast episode from the command line"
  homepage "https://aludel.matteobalocco.it/cli.html"
  url "https://github.com/totanus/aludel-releases/releases/download/cli-v0.1.3/aludel-cli-macos-aarch64-0.1.3.zip"
  sha256 "49e73a52e09de022f66ed42f08c4869266ccac0d3c064c7955ff0b840a1f6948"
  license :cannot_represent
  version "0.1.3"

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
