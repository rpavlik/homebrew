require 'formula'

class GitMultipush <Formula
  url 'http://github.com/gavinbeatty/git-multipush/tarball/git-multipush-v2.4.rc2'
  homepage 'http://code.google.com/p/git-multipush/'
  version '2.4.rc2'
  md5 '4af53b87195a29d34f2760842ee2e9c1'

  # Not depending on git because people might have it
  # installed through another means

  def install
    system "make", "VERSION=#{version}", "prefix=#{prefix}", "install"
  end
end
