require 'formula'

class Vrjuggler30 <Formula
  head 'http://vrjuggler.googlecode.com/svn/juggler/trunk/'
  homepage 'http://code.google.com/p/vrjuggler/'

 depends_on 'boost'
 depends_on 'cppdom'
 depends_on 'gmtl'
 depends_on 'flagpoll'

	def install
		args = ["--prefix=#{prefix}", "--with-boost=#{HOMEBREW_PREFIX}"]
		
		ENV['ACLOCAL_FLAGS'] = "-I #{HOMEBREW_PREFIX}/share/aclocal"
		ENV['FLAGPOLL_PATH'] = "#{HOMEBREW_PREFIX}/lib/flagpoll:#{HOMEBREW_PREFIX}/share/flagpoll"
		ENV['AUTOCONF'] = "autoconf"
		ENV['AUTOHEADER'] = "autoheader"
		ENV['ACLOCAL'] = "aclocal-1.10"
		ENV['CC'] = "gcc"
		ENV['CXX'] = "g++"
		
		# Make the default Java location correct
		inreplace 'modules/tweek/java/tweek-base.sh.in' do |contents| 
			contents.gsub! /\/usr\/java/, '/usr'
		end
		
		system "./autogen.sh"
		system "./configure.pl", *args
		system "make", "optim"
		system "make", "install-optim"
	end
end
