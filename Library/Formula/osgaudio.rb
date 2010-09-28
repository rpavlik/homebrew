require 'formula'

class Osgaudio <Formula
  url 'http://osgaudio.googlecode.com/files/osgAudio200.tar.gz'
  homepage 'http://code.google.com/p/osgaudio/'
  md5 'bf3c02a1bcf6815a188f71023673be98'

  depends_on 'cmake'
  depends_on 'openscenegraph'
  depends_on 'freealut'
  depends_on 'libogg'
  depends_on 'libvorbis'

  def install
    #system "./configure", "--disable-debug", "--disable-dependency-tracking",
    #                      "--prefix=#{prefix}"
    args = [".", "-DFMOD_INCLUDE_DIR=/Developer/FMOD/api/inc", "-DFMOD_LIBRARY=/Developer/FMOD/api/lib/libfmodex.dylib"]
    system "cmake", *args
    system "make install"
  end
end
