class Wellington < Formula
  desc "Project-focused tool to manage Sass and spriting"
  homepage "https://github.com/wellington/wellington"
  url "https://github.com/wellington/wellington/archive/v1.0.5.tar.gz"
  sha256 "e2379722849cdd8e5f094849290aacba4b789d4d65c733dec859565c728e7205"
  license "Apache-2.0"
  head "https://github.com/wellington/wellington.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "27f36c238e415ad9209494e1760b9bcb64fddc52fd45c8b7a4cd218e603e6503"
    sha256 cellar: :any_skip_relocation, big_sur:       "1042d237d74c534c987e63bb1e4eef6ec4070a1c9b080e52283d65c5edd9e40a"
    sha256 cellar: :any_skip_relocation, catalina:      "9aaeb3a098cbee88efc4e60d1edbfec242d6b2271f821b4d096fe6acb3d16987"
    sha256 cellar: :any_skip_relocation, mojave:        "a49538429713f2f7b979ab533d4231de84140d9e4e63b5658941552c1c99117a"
    sha256 cellar: :any_skip_relocation, high_sierra:   "53a61eeebc1e787fa7870437ce089276c5f1daad26430078e988d1b6aa50c7b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4475484cb2378a741c1cfdcdabc95b5ea175202c1b78ce2481d23aff35fb3da4" # linuxbrew-core
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
            "-X github.com/wellington/wellington/version.Version=#{version}",
            "-o", bin/"wt", "wt/main.go"
  end

  test do
    s = "div { p { color: red; } }"
    expected = <<~EOS
      /* line 1, stdin */
      div p {
        color: red; }
    EOS
    assert_equal expected, pipe_output("#{bin}/wt --comment", s, 0)
  end
end
