require 'formula'

class Cppdom <Formula
  url 'http://downloads.sourceforge.net/project/xml-cppdom/CppDOM/1.0.1/cppdom-1.0.1.tar.gz'
  homepage ''
  md5 ''

 depends_on 'scons'

  def install
    system "scons", "install", "prefix=#{prefix}", "build_test=no", "var_arch=ia32"
  end
end
