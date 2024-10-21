{ fetchPypi, python3Packages, pythonNethsm, pythonNitrokey }:
python3Packages.buildPythonApplication rec {
  pname = "pynitrokey";
  version = "0.6.0";
  pyproject = true;

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-pY6ATORZDPGRnkN6dse1s/DzQRpplDbPAGUHU4E7U9M=";
  };

  nativeBuildInputs = [
    python3Packages.pythonRelaxDepsHook
  ];

  build-system = [
    python3Packages.flit-core
  ];

  dependencies = with python3Packages; [
    certifi
    cffi
    click
    cryptography
    ecdsa
    fido2
    intelhex
    nkdfu
    pythonNitrokey
    python-dateutil
    pyusb
    requests
    tqdm
    tlv8
    typing-extensions
    click-aliases
    semver
    pythonNethsm
    pyscard
    asn1crypto
  ];

  pypaBuildFlags = [
    "--skip-dependency-check"
  ];

  pythonRelaxDeps = [
    "click"
    "python-dateutil"
    "typing_extensions"
  ];
}
