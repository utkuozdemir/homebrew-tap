class TouchToSign < Formula
  desc "Show a popup on macOS while git waits for a YubiKey touch to sign"
  homepage "https://github.com/utkuozdemir/touch-to-sign"
  url "https://github.com/utkuozdemir/touch-to-sign/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "be4c01223a59a23e1c21775e7c8f83ec123ae64d4179f39871a3a5c7a5b22dac"
  license "MIT"
  head "https://github.com/utkuozdemir/touch-to-sign.git", branch: "main"

  depends_on macos: :ventura

  def install
    system "swiftc", "-O", "-o", "touch-to-sign", "touch-to-sign.swift"
    bin.install "touch-to-sign"
  end

  def caveats
    <<~EOS
      To sign through touch-to-sign, run:
        git config --global gpg.program "#{HOMEBREW_PREFIX}/bin/touch-to-sign"
    EOS
  end

  test do
    ENV["GIT_CONFIG_COUNT"] = "1"
    ENV["GIT_CONFIG_KEY_0"] = "touch-to-sign.program"
    ENV["GIT_CONFIG_VALUE_0"] = "/bin/echo"
    assert_equal "--verify x", shell_output("#{bin}/touch-to-sign --verify x").strip
  end
end
