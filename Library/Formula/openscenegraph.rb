require 'formula'

class Openscenegraph <Formula
  url 'http://www.openscenegraph.org/downloads/stable_releases/OpenSceneGraph-2.8.3/source/OpenSceneGraph-2.8.3.zip'
  homepage 'http://www.openscenegraph.org/'
  md5 ''
  
 depends_on 'cmake'
 depends_on 'pcre'
 depends_on 'ffmpeg'
 depends_on 'gdal'
 depends_on 'jasper'
 depends_on 'openexr'
 
  def install
   system "cmake . #{std_cmake_parameters} -DBUILD_OSG_WRAPPERS=ON -DCMAKE_OSX_ARCHITECTURES=i386"
    system "make install"
  end
end
