# Based on:
# https://github.com/NixOS/nixpkgs/blob/b84f55850ada9b306653cb2f3b768078ce46a9ed/pkgs/development/python-modules/pc-ble-driver-py/default.nix

{
  python3,
  boost,
  cmake,
  fetchFromGitHub,
  pc-ble-driver,
  git,
  swig,
}:
python3.pkgs.buildPythonPackage rec {
  pname = "pc-ble-driver-py";
  version = "0.17.0";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "NordicSemiconductor";
    repo = "pc-ble-driver-py";
    rev = "refs/tags/v${version}";
    hash = "sha256-brC33ar2Jq3R2xdrklvVsQKf6pcnKwD25PO4TIvXgTg=";
  };

  nativeBuildInputs = [
    cmake
    swig
    git
    python3.pkgs.setuptools
    python3.pkgs.scikit-build
  ];

  buildInputs = [
    boost
    pc-ble-driver
  ];

  propagatedBuildInputs = [
    python3.pkgs.cryptography
    python3.pkgs.wrapt
  ];

  dontUseCmakeConfigure = true;

  # doCheck tries to write to the global python directory to install things
  doCheck = false;

  pythonImportsCheck = [ "pc_ble_driver_py" ];
}
