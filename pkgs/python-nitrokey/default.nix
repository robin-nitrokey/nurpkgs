{ fetchPypi, python3Packages }:
python3Packages.buildPythonPackage rec {
  pname = "nitrokey";
  version = "0.2.0";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-oWfhy7Mj1UnrC70G7fpkl4q4uG0CdvO0BHwfJYszR30=";
  };

  nativeBuildInputs = [
    python3Packages.pythonRelaxDepsHook
  ];

  build-system = [
    python3Packages.poetry-core
  ];

  dependencies = with python3Packages; [
    crcmod
    cryptography
    ecdsa
    fido2
    hidapi
    protobuf
    pyserial
    requests
    semver
    tlv8
  ];

  pythonImportsCheck = [
    "nitrokey"
  ];

  pythonRelaxDeps = [
    "protobuf"
  ];
}
