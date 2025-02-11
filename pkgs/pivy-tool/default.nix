{
  stdenv,
  fetchzip,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  libbsd,
  pcsclite,
  zlib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "pivy-tool";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "arekinath";
    repo = "pivy";
    tag = "v${finalAttrs.version}";
    hash = "sha256-FEIIZTtFXN+vBz/kVsRIgj1vSJ/m8vcug1mVBLgTbnU=";
  };

  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
  ];
  buildInputs = [
    libbsd
    pcsclite
    zlib
  ];
  preBuild =
    let
      openssh = fetchzip {
        name = "openssh";
        url = "https://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-9.5p1.tar.gz";
        hash = "sha256-wku+o0t1daPfVDXVNkavqDLV5r81iM2UWt0jniOEG9Q=";
      };
      libressl = fetchzip {
        name = "libressl";
        url = "https://ftp.openbsd.org/pub/OpenBSD/LibreSSL/libressl-3.8.2.tar.gz";
        hash = "sha256-VWlaxCOukbleb98kmMS/7YWpWm+wDJCVYYcONdkgH4A=";
      };
    in
    ''
      cp --recursive ${libressl} libressl
      cp --recursive ${openssh} openssh
      chmod ug+w -R libressl openssh
      touch .libressl.extract .openssh.extract openssh/configure
    '';
  buildFlags = [ "pivy-tool" ];

  installPhase = ''
    install -D -t $out/bin pivy-tool
  '';
})
