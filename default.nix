{
  pkgs ? import <nixpkgs> {},
}:
{
  pythonNethsm = pkgs.callPackage ./pkgs/python-nethsm {};
  pythonNitrokey = pkgs.callPackage ./pkgs/python-nitrokey {};
}
