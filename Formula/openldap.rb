class Openldap < Formula
  desc "Open source suite of directory software"
  homepage "https://www.openldap.org/software/"
  url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/openldap-2.5.6.tgz"
  sha256 "3f21423a9d3bd9774a4494e2d4fbc830ac68d63a87d4c2934eff800954cac11f"
  license "OLDAP-2.8"

  livecheck do
    url "https://www.openldap.org/software/download/OpenLDAP/openldap-release/"
    regex(/href=.*?openldap[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 arm64_big_sur: "4c7569397187e1a9a102d2b382f4f93ef0dd442aba3bd35f05f66e684beff6e4"
    sha256 big_sur:       "395680ec39b04d28561b24fa29cafc297d5b09abf8d30999627832edc7c47e19"
    sha256 catalina:      "752cc8533a6efacfd6e67b695f7cf4de81364f94416fc9e854245e6d71a7e3bf"
    sha256 mojave:        "95b514e1fd902a0f484151102bcee46446cf7ce7b30c6eaeae501f8c2903390b"
    sha256 x86_64_linux:  "a4ca42e868a6bfa0b564220a6c8538708a770391255fb8c09c9ea286ef5fa34e" # linuxbrew-core
  end

  keg_only :provided_by_macos

  depends_on "openssl@1.1"

  on_linux do
    depends_on "util-linux"
  end

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --sysconfdir=#{etc}
      --localstatedir=#{var}
      --enable-accesslog
      --enable-auditlog
      --enable-bdb=no
      --enable-constraint
      --enable-dds
      --enable-deref
      --enable-dyngroup
      --enable-dynlist
      --enable-hdb=no
      --enable-memberof
      --enable-ppolicy
      --enable-proxycache
      --enable-refint
      --enable-retcode
      --enable-seqmod
      --enable-translucent
      --enable-unique
      --enable-valsort
      --without-systemd
    ]

    # Disable manpage generation
    inreplace "Makefile.in" do |s|
      s.change_make_var! "SUBDIRS", "include libraries clients servers"
    end

    system "./configure", *args
    system "make", "install"
    (var/"run").mkpath

    # https://github.com/Homebrew/homebrew-dupes/pull/452
    chmod 0755, Dir[etc/"openldap/*"]
    chmod 0755, Dir[etc/"openldap/schema/*"]
  end

  test do
    system sbin/"slappasswd", "-s", "test"
  end
end
