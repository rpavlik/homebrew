require 'formula'

class Vrjuggler30 <Formula
  head 'http://vrjuggler.googlecode.com/svn/juggler/branches/3.0/'
  homepage 'http://code.google.com/p/vrjuggler/'
  url 'http://vrjuggler.googlecode.com/files/vrjuggler-3.0-beta1-src.tar.bz2'
  sha1 'f727ddcc858c154a53051654a1b3eea666bfe98b'

  depends_on 'boost'
  depends_on 'cppdom'
  depends_on 'gmtl'
  depends_on 'flagpoll'
  depends_on 'freealut' => :recommended
  depends_on 'vrpn' => :recommended
  #depends_on 'omniorb' => :optional

  def install
    #if Formula.factory('vrjuggler-2.2').installed?
    #  ohai 'Unlinking vrjuggler-2.2 before installing vrjuggler-3.0'
    #  system "brew", "unlink", "vrjuggler-2.2"
    #end

    args = ["--prefix=#{prefix}",
      "--with-boost=#{HOMEBREW_PREFIX}"]

    if Formula.factory("freealut").installed?
      args << "--with-alut=#{HOMEBREW_PREFIX}"
    end

    if Formula.factory("vrpn").installed?
      args << "--with-vrpn=#{HOMEBREW_PREFIX}"
    end

    if Formula.factory("omniorb").installed?
      args << "--with-cxx-orb=omniORB4"
      args << "--with-cxx-orb-root=#{HOMEBREW_PREFIX}"
    end

    # For some reason, juggler fails to build nicely in parallel in any kind
    # of packinging-like setup
    ENV.deparallelize()

    # Make our local aclocal dir before autogen, to be safe and avoid errors
    system "mkdir -p #{prefix}/share/aclocal"

    ENV['ACLOCAL_FLAGS'] = "-I #{prefix}/share/aclocal -I #{HOMEBREW_PREFIX}/share/aclocal"
    ENV['FLAGPOLL_PATH'] = "#{prefix}/lib/flagpoll:#{prefix}/share/flagpoll:#{HOMEBREW_PREFIX}/lib/flagpoll:#{HOMEBREW_PREFIX}/share/flagpoll"
    ENV['AUTOCONF'] = "autoconf"
    ENV['AUTOHEADER'] = "autoheader"
    ENV['ACLOCAL'] = "aclocal-1.10"
    if not ARGV.include? '--use-llvm'
      ENV['CC'] = "gcc"
      ENV['CXX'] = "g++"
    end

    # Make the default Java location correct
    inreplace 'modules/tweek/java/tweek-base.sh.in' do |contents|
      contents.gsub! /\/usr\/java/, '/usr'
    end

    system "./autogen.sh"

    # The prefix set here is immediately written to, so using the keg.
    system "./configure.pl", *args

    # setting the instprefix variable to put the homebrew prefix as the
    # libraries' "known root dir", while installing to the keg.

    # Make only the optimized shared libraries
    system "make", "opt-dso", "instprefix=#{HOMEBREW_PREFIX}"

    # Install all available optimized libraries - in this case, only
    # shared available, static are peacefully ignored.
    system "make", "install-optim", "instprefix=#{HOMEBREW_PREFIX}"
  end

  def caveats
    "VRJConfig.app and Tweek.app installed to #{prefix} - you may copy them to /Applications if you like."
  end
end
