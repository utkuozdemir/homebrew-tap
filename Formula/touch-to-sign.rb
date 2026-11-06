class TouchToSign < Formula
  desc "Show a popup on macOS while git waits for a YubiKey touch to sign"
  homepage "https://github.com/utkuozdemir/touch-to-sign"
  url "https://github.com/utkuozdemir/touch-to-sign/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "afd8f5099703a09d21de7ede3ff7cff271a11e8d18c3e022bad2f5c3d4c3e612"
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
