require 'formula'

class TmuxIterm2 < Formula
  url 'http://iterm2.googlecode.com/files/iTerm2-1_0_0_20130122.zip'
  sha1 'a5f55b545500ebcb97e842f65ea9c90dd457f228'
  homepage 'http://github.com/gnachman/tmux2'

  depends_on 'libevent'
  depends_on :automake
  depends_on :libtool
  depends_on 'pkg-config'


  def install
    ENV.append "LDFLAGS", '-lresolv'
     
    system("tar -xvf tmux*.tar.gz")
    Dir.chdir "tmux"
    system  "sh", "autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}", "--sysconfdir=#{etc}"
    system "make install"

    # Install bash completion scripts for use with bash-completion
    (prefix+'etc/bash_completion.d').install "examples/bash_completion_tmux.sh" => 'tmux-iterm2'
  end

  def caveats; <<-EOS.undent
    Bash completion script was installed to:
      #{etc}/bash_completion.d/tmux-iterm2
    EOS
  end
end
