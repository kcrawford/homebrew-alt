require 'formula'

class TmuxIterm2 < Formula
  url 'http://iterm2.googlecode.com/files/iTerm2-1_0_0_20120726.zip'
  md5 '596c8ff70a836f67ee3197bb60cf92b3'
  homepage 'http://github.com/gnachman/tmux2'

  depends_on 'libevent'

  def install
    ENV.append "LDFLAGS", '-lresolv'
    system("tar -xvf tmux*.tar.gz")
    Dir.chdir "tmux"
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
