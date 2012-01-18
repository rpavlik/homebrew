require 'formula'

class Omniorb <Formula
  url 'http://omniorb.sourceforge.net/releases/omniORB-4.1.4.tar.gz'
  homepage 'http://omniorb.sourceforge.net/'
  md5 '1f6070ff9b6339876976d61981eeaa6a'

  depends_on 'pkg-config' => :optional
  depends_on 'openssl' => :optional

  def install
  	args = ["--disable-debug",
  	  "--disable-dependency-tracking",
  	  "--prefix=#{prefix}",
  	  "--with-omniORB-config=#{etc}/omniORB.cfg",
      "--with-omniNames-logdir=#{var}/omninames"
      #, "--with-openssl=/usr"
      ]
    if Formula.factory("openssl").installed?
      args << "--with-openssl=#{Formula.factory('openssl').prefix}"
    end

    # MacPorts did it
    inreplace "configure", ",prefix='$PYTHON_PREFIX'", ""
    inreplace "configure", ",prefix='$PYTHON_EXEC_PREFIX'", ""


    system "./configure", *args

    system "make"

    system "make install"
  end
end
