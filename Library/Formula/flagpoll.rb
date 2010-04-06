require 'formula'

class Flagpoll <Formula
  url 'http://flagpoll.googlecode.com/files/flagpoll-0.9.1.tar.gz'
  homepage 'http://code.google.com/p/flagpoll/'
  md5 'c4ac50ae99a880704abfc62a64ed16aa'

  def install
    system "./setup.py", "install", "--prefix=#{prefix}"
  end
end
