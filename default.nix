{
  pkgs ? import <nixpkgs> { },
}:
let
  allpkgs = pkgs // nurpkgs;
  callPackage = pkgs.lib.callPackageWith allpkgs;
  nurpkgs = {
    lpc55-host = callPackage ./pkgs/lpc55-host { };
    nethsm-pkcs11 = callPackage ./pkgs/nethsm-pkcs11 { };
    pythonNethsm = callPackage ./pkgs/python-nethsm { };
    pythonNitrokey = callPackage ./pkgs/python-nitrokey { };
    pynitrokey = callPackage ./pkgs/pynitrokey { };
    segger-jlink-cli = callPackage ./pkgs/segger-jlink-cli { };
  };
in
nurpkgs
