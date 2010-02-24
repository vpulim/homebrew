require 'formula'

class Boost <Formula
  @homepage='http://www.boost.org'
  @url='http://downloads.sourceforge.net/project/boost/boost/1.42.0/boost_1_42_0.tar.bz2'
  @md5='7bf3b4eb841b62ffb0ade2b82218ebe6'

  def install
    # we specify libdir too because the script is apparently broken
    system "./bootstrap.sh --prefix='#{prefix}' --libdir='#{lib}'"
    system "./bjam --layout=tagged --prefix='#{prefix}' --libdir='#{lib}' threading=multi install"
  end
end

 
