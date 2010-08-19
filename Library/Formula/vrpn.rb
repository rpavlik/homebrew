require 'formula'

class Vrpn <Formula
  # We'll use this again when the below commit is merged
  #url 'git://git.cs.unc.edu/vrpn.git', :revison => ''
  url 'git://github.com/rpavlik/vrpn.git', :revision => '03fada7a988f7e182f16'
  version '07.26.2'
  head 'git://git.cs.unc.edu/vrpn.git'
  homepage 'http://vrpn.org'

  depends_on 'cmake'

  def install
    Dir.mkdir "build"
    Dir.chdir "build" do
	  system "cmake .. #{std_cmake_parameters}"
      system "make install"
	end
  end
end
