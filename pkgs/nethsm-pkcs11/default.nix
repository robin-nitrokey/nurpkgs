{ fetchFromGitHub, rustPlatform }:
rustPlatform.buildRustPackage rec {
  pname = "nethsm-pkcs11";
  version = "1.3.0";

  src = fetchFromGitHub {
    owner = "Nitrokey";
    repo = pname;
    rev = version;
    hash = "sha256-yL0yP0LG2Lrf5VjB4X+sUjzD6tI/VvUNaAmuTzqSjPo=";
  };

  cargoHash = "sha256-mN6Y7fTXR7CsSK15Fkku/eGuYd+uOQes8zeAM5cybf8=";

  doCheck = false;
}
