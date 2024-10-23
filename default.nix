{
  pkgs ? import <nixpkgs> { },
}:
let
  allpkgs = pkgs // nurpkgs;
  callPackage = pkgs.lib.callPackageWith allpkgs;
  nurpkgs = {
    nethsm-pkcs11 = callPackage ./pkgs/nethsm-pkcs11 { };
    pythonNethsm = callPackage ./pkgs/python-nethsm { };
    pythonNitrokey = callPackage ./pkgs/python-nitrokey { };
    pynitrokey = callPackage ./pkgs/pynitrokey { };
  };
in
nurpkgs
