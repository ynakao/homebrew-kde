class Kf5Kauth < Formula
  desc "Abstraction to system policy and authentication features"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.42/kauth-5.42.0.tar.xz"
  sha256 "91ebf3554551c3815e89e53e577e42d7cc3ac1f4966215fbbc93a60ca1587812"
  revision 1

  head "git://anongit.kde.org/kauth.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build

  depends_on "gpgme"
  depends_on "KDE-mac/kde/kf5-kcoreaddons"

  stable do
    patch do
      url "https://phabricator.kde.org/file/data/lluzmyjcrc2xpugju5i3/PHID-FILE-23iilpt2fa6dgvorfyf7/file"
      sha256 "88aa133b1c3ffcb6255a024ae611c8a0dfcf826c6a4d72b61fb577abc83bc2a9"
    end
  end

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      prefix.install "install_manifest.txt"
    end
  end

  def caveats; <<-EOS.undent
    You need to take some manual steps in order to make this formula work:
      ln -sf "$(brew --prefix)/share/kf5" "$HOME/Library/Application Support"
     EOS
  end
end
