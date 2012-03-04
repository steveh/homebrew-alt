require 'formula'

class Tuntap < Formula
  url 'http://downloads.sourceforge.net/tuntaposx/tuntap_20111101_src.tar.gz'
  homepage 'http://tuntaposx.sourceforge.net/'
  md5 '852593304085e7e36743ac11a9de82fc'

  def install
    system "make all"
    (prefix+"Extensions").mkpath
    (prefix+"StartupItems").mkpath
    (prefix+"Extensions").install "tap.kext"
    (prefix+"Extensions").install "tun.kext"
    (prefix+"StartupItems").install "startup_item/tap"
    (prefix+"StartupItems").install "startup_item/tun"
  end

  def caveats
    <<-EOS.undent
      In order for tun/tap to work, the extensions must be loaded by root:

        sudo mkdir -p /Library/Extensions /Library/StartupItems
        sudo cp -pR #{prefix}/Extensions/tap.kext /Library/Extensions/
        sudo cp -pR #{prefix}/Extensions/tun.kext /Library/Extensions/
        sudo cp -pR #{prefix}/StartupItems/tap /Library/StartupItems/
        sudo cp -pR #{prefix}/StartupItems/tun /Library/StartupItems/
        sudo chown -R root:wheel /Library/Extensions/tap.kext /Library/Extensions/tun.kext /Library/StartupItems/tap /Library/StartupItems/tun
    EOS
  end
end
