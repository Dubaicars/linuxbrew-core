class Tinyxml2 < Formula
  desc "Improved tinyxml (in memory efficiency and size)"
  homepage "http://grinninglizard.com/tinyxml2"
  url "https://github.com/leethomason/tinyxml2/archive/9.0.0.tar.gz"
  sha256 "cc2f1417c308b1f6acc54f88eb70771a0bf65f76282ce5c40e54cfe52952702c"
  license "Zlib"
  head "https://github.com/leethomason/tinyxml2.git"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "a5c5e7ea6dcc446b1f7d38441ac4a226afa14b3e5e5eb890d3105edf54f91db6"
    sha256 cellar: :any,                 big_sur:       "4df58f65bc6629e1884225503622e07f26e52a9690e24a6e959dd1304b11dbb8"
    sha256 cellar: :any,                 catalina:      "d09e9f6a1833923fea9528a056c663cb5e05b71afacc1fcec7b9b6fbeb30772f"
    sha256 cellar: :any,                 mojave:        "84db2d094fa220b2269cd97bed3fb50edfd23061f6ab9dece09a82562e73a975"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c3309307a6ddad63d4ef83da82dc33488796775d1aaac1eec0a19d843fc1f9d4" # linuxbrew-core
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args, "-Dtinyxml2_SHARED_LIBS=ON"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <tinyxml2.h>
      int main() {
        tinyxml2::XMLDocument doc (false);
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-ltinyxml2", "-o", "test"
    system "./test"
  end
end
