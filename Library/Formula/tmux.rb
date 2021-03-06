class Tmux < Formula
  desc "Terminal multiplexer"
  homepage 'http://tmux.sourceforge.net'
  url 'https://downloads.sourceforge.net/project/tmux/tmux/tmux-2.0/tmux-2.0.tar.gz'
  sha1 '977871e7433fe054928d86477382bd5f6794dc3d'

  bottle do
    cellar :any
    revision 1
    sha256 "4a15dbb353298f6ab5db3ad0121e50225328d49da1548bee570f93af4c294368" => :yosemite
    sha256 "ccc3e43a9e544d74d5a081de07294a8c75d14f9649d7fc2e5bc94cc0107e625d" => :mavericks
    sha256 "145f66ff2b0adf499ee4a8ceab8ec1556d43b74074921ff1e86a4d7be05492c8" => :mountain_lion
  end

  head do
    url "https://github.com/tmux/tmux.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libevent"

  def install
    system "sh", "autogen.sh" if build.head?

    ENV.append "LDFLAGS", "-lresolv"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"

    system "make", "install"

    bash_completion.install "examples/bash_completion_tmux.sh" => "tmux"
    (share/"tmux").install "examples"
  end

  def caveats; <<-EOS.undent
    Example configurations have been installed to:
      #{share}/tmux/examples
    EOS
  end

  test do
    system "#{bin}/tmux", "-V"
  end
end
