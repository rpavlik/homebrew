require 'formula'

class Flagpoll <Formula
  url 'http://flagpoll.googlecode.com/files/flagpoll-0.9.1.tar.gz'
  homepage ''
  md5 ''

# depends_on 'cmake'

  def install
    system "./setup.py", "install", "--prefix=#{prefix}"
  end
end
