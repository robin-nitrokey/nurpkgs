{
  stdenv,
  autoPatchelfHook,
  segger-jlink,
}:
stdenv.mkDerivation {
  pname = "segger-link-cli";
  inherit (segger-jlink)
    src
    version
    dontConfigure
    dontBuild
    appendRunpaths
    ;

  nativeBuildInputs = [ autoPatchelfHook ];

  installPhase = ''
    runHook preInstall

    # Install binaries and runtime files into /opt/
    mkdir -p $out/opt
    mv JLinkExe JLinkGDBServerCLExe $out/opt

    # Link executables into /bin/
    mkdir -p $out/bin
    for binr in $out/opt/*Exe; do
      ln -s $binr $out/bin
    done

    # Copy special alias symlinks
    for slink in $(find $out/opt/. -type l); do
      cp -P -n $slink $out/bin || true
      rm $slink
    done

    # Install libraries
    install -Dm444 libjlinkarm.so* -t $out/lib
    for libr in $out/lib/libjlinkarm.*; do
      ln -s $libr $out/opt
    done

    # Install udev rules
    install -Dm444 99-jlink.rules -t $out/lib/udev/rules.d/

    runHook postInstall
  '';
}
