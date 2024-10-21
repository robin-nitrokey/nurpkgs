{
  pkgs ? import <nixpkgs> {},
}:
let
  allpkgs = pkgs // nurpkgs;
  callPackage = pkgs.lib.callPackageWith allpkgs;
  nurpkgs = {
    pythonNethsm = callPackage ./pkgs/python-nethsm {};
    pythonNitrokey = callPackage ./pkgs/python-nitrokey {};
    pynitrokey = callPackage ./pkgs/pynitrokey {};
  };
in
nurpkgs
