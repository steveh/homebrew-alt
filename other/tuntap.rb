require 'formula'

class Tuntap < Formula
  url 'http://downloads.sourceforge.net/tuntaposx/tuntap_20111101_src.tar.gz'
  homepage 'http://tuntaposx.sourceforge.net/'
  md5 '852593304085e7e36743ac11a9de82fc'

  def install
    system "make all"
    system "mkdir -p #{prefix}/Extensions #{prefix}/StartupItems"
    system "cp -pR tap.kext #{prefix}/Extensions/tap.kext"
    system "cp -pR tun.kext #{prefix}/Extensions/tun.kext"
    system "cp -pR startup_item/tap #{prefix}/StartupItems/tap"
    system "cp -pR startup_item/tun #{prefix}/StartupItems/tun"
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
