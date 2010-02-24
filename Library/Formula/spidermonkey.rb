require 'formula'

class Spidermonkey <Formula
  url 'http://hg.mozilla.org/mozilla-central/archive/ddfecbc93934.tar.gz'
  md5 'bff7b9a466516c8ab80cf8ee0170735d'

  version '1.9.3'

  homepage 'https://developer.mozilla.org/en/SpiderMonkey'

  head 'hg://http://hg.mozilla.org/mozilla-central'

  depends_on 'readline'
  depends_on 'nspr'

  # !!! spidermonkey will only build with autoconf 2.13
  depends_on 'autoconf213' 

  def install

    Dir.chdir "js/src" do
      system "autoconf213"
    end

    FileUtils.mkdir "brew-build";

    Dir.chdir "brew-build" do
      system "../js/src/configure", "--prefix=#{prefix}",
                                    "--enable-readline",
                                    "--enable-threadsafe",
                                    "--with-system-nspr"

      inreplace "js-config", /JS_CONFIG_LIBS=.*?$/, "JS_CONFIG_LIBS=''"

      system "make"
      system "make install"

      # The `js` binary ins't installed. Lets do that too, eh?
      bin.install "shell/js"
    end

  end
end


class Autoconf213 <Formula
  url 'http://ftp.gnu.org/pub/gnu/autoconf/autoconf-2.13.tar.gz'
  md5 '9de56d4a161a723228220b0f425dc711'
  homepage 'http://www.gnu.org/software/autoconf/'
end
