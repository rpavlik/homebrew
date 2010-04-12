require 'formula'
require 'hardware'

class Tbb30 <Formula
  url 'http://www.threadingbuildingblocks.org/uploads/77/148/3.0/tbb30_20100310oss_src.tgz'
  homepage 'http://www.threadingbuildingblocks.org/'
  md5 'a7dc9b6aa6f33e6f6228cdc26c4a0899'

  def install
  	args = ['tbb_build_prefix=BUILDPREFIX']
  	if MACOS_VERSION >= 10.6 and hardware.is_64_bit?
  		args << "arch=intel64"
  	else
  		args << "arch=ia32"
  	end
	system "make", *args
	lib.install Dir['build/BUILDPREFIX_release/*.dylib']
	include.install Dir['include/tbb']
  end
end
