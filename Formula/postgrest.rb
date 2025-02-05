class Postgrest < Formula
  desc "Serves a fully RESTful API from any existing PostgreSQL database"
  homepage "https://github.com/PostgREST/postgrest"
  url "https://github.com/PostgREST/postgrest/archive/v8.0.0.tar.gz"
  sha256 "4a930900b59866c7ba25372fd93d2fbab5cdb52fc5fea5e481713b03a2d5e923"
  license "MIT"
  head "https://github.com/PostgREST/postgrest.git"

  bottle do
    sha256 cellar: :any,                 big_sur:      "86fa2836b2d7547599f35eb3722277567cd987a9147a4b954d81952d14d053f2"
    sha256 cellar: :any,                 catalina:     "8a89348403a8b4006a3060c58a690d23e616386cd960e36c9d317866626afe9f"
    sha256 cellar: :any,                 mojave:       "6292a68089f055e64a4b249f73a595d51f25c4c2797dee6a1d449734192cc174"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bdbe91f9ecc5f638a29a2894e2c354c6eb9c10a537c46bfc1e130c590b4d91d6" # linuxbrew-core
  end

  depends_on "cabal-install" => :build
  depends_on "ghc@8.8" => :build
  depends_on "postgresql"

  def install
    system "cabal", "v2-update"
    system "cabal", "v2-install", *std_cabal_v2_args
  end
end
