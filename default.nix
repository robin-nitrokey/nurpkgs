{
  pkgs ? import <nixpkgs> {},
}:
{
  pythonNethsm = pkgs.callPackage ./pkgs/python-nethsm {};
}
