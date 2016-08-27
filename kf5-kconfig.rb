require "formula"

class Kf5Kconfig < Formula
  url "http://download.kde.org/stable/frameworks/5.25/kconfig-5.25.0.tar.xz"
  sha256 "498332f1c3fbb5e0d681cf6807502c1fe0aef74e79b29cd1e60e4096924949c2"
  homepage "http://www.kde.org/"

  head 'git://anongit.kde.org/kconfig.git'

  depends_on "cmake" => :build
  depends_on "haraldf/kf5/kf5-extra-cmake-modules" => :build
  depends_on "qt5" => "with-dbus"

  def patches
    DATA
  end

  def install
    args = std_cmake_args


    system "cmake", ".", *args
    system "make", "install"
    prefix.install "install_manifest.txt"

    mkdir_p "#{HOMEBREW_PREFIX}/lib/kde5/libexec"
    ln_sf "#{lib}/kde5/libexec/kconf_update", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"
    ln_sf "#{lib}/kde5/libexec/kconfig_compiler_kf5", "#{HOMEBREW_PREFIX}/lib/kde5/libexec/"
  end
end

__END__
diff --git a/src/kconfig_compiler/CMakeLists.txt b/src/kconfig_compiler/CMakeLists.txt
index 368a4d8..004a649 100644
--- a/src/kconfig_compiler/CMakeLists.txt
+++ b/src/kconfig_compiler/CMakeLists.txt
@@ -20,4 +20,6 @@ find_package(Qt5Xml ${REQUIRED_QT_VERSION} REQUIRED NO_MODULE)
 
 target_link_libraries(kconfig_compiler Qt5::Xml)
 
+ecm_mark_nongui_executable(kconfig_compiler)
+
 install(TARGETS kconfig_compiler EXPORT KF5ConfigCompilerTargets DESTINATION ${KDE_INSTALL_LIBEXECDIR_KF5})
