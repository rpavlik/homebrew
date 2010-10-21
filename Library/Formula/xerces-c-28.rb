require 'formula'

class XercesC28 <Formula
  url 'http://mirror.olnevhost.net/pub/apache//xerces/c/2/sources/xerces-c-src_2_8_0.tar.gz'
  homepage 'http://xerces.apache.org/xerces-c/'
  md5 '5daf514b73f3e0de9e3fce704387c0d2'
  
  def patches
    {:p0 => "http://svn.macports.org/repository/macports/trunk/dports/textproc/xercesc/files/64-bit-no-carbon.diff"}
  end


  def install
	srcdir = Dir.getwd
	Dir.chdir 'src/xercesc' do
	  ENV["XERCESCROOT"] = "#{srcdir}"
	  ENV.deparallelize
	  args = ["-p", "macosx","-P", "#{prefix}","-n", "native", "-z", "-I#{srcdir}/src"]
	  if snow_leopard_64?
		args << "-b"
		args << "64"
	  end
	  system "./runConfigure", *args
	  system "make"
      system "make install"
	end
  end
end
