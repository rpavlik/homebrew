require 'formula'

class XercesC <Formula
  url 'http://mirror.olnevhost.net/pub/apache//xerces/c/2/sources/xerces-c-src_2_8_0.tar.gz'
  homepage 'http://xerces.apache.org/xerces-c/'
  md5 '5daf514b73f3e0de9e3fce704387c0d2'

  def install
    system "./runConfigure","-pmacosx","-P#{prefix}","-nnative"
    system "make install"
  end
end
