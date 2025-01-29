{
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  udev,
}:
let
  version = "0.2.1";
in
rustPlatform.buildRustPackage {
  pname = "lpc55-host";
  inherit version;

  src = fetchFromGitHub {
    owner = "lpc55";
    repo = "lpc55-host";
    rev = version;
    hash = "sha256-lOmC43jrpV+Zpq4OGIq6fpRvZgGaprFH5Zi2H5qrUy4=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  cargoLock.lockFile = ./Cargo.lock;
  postPatch = ''
    ln -s ${./Cargo.lock} Cargo.lock
  '';
}
