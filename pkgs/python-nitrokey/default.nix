{ fetchPypi, python3Packages }:
python3Packages.buildPythonPackage rec {
  pname = "nitrokey";
  version = "0.2.2";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-tG6+diyrauJEzpPG33+S5o1ik3n44/443szR7vXH4gE=";
  };

  nativeBuildInputs = [ python3Packages.pythonRelaxDepsHook ];

  build-system = [ python3Packages.poetry-core ];

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

  pythonImportsCheck = [ "nitrokey" ];

  pythonRelaxDeps = [ "protobuf" ];
}
