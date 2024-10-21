{ fetchPypi, python3Packages }:
python3Packages.buildPythonPackage rec {
  pname = "nethsm";
  version = "1.2.1";
  pyproject = true;
  
  src = fetchPypi {
    inherit pname version;
    hash = "sha256-EPxGJFCGGl3p3yLlM7NH7xtEVS2woRigKJhL57A0gAE=";
  };

  nativeBuildInputs = [
    python3Packages.pythonRelaxDepsHook
  ];

  build-system = [
    python3Packages.flit-core
  ];

  dependencies = with python3Packages; [
    certifi
    cryptography
    python-dateutil
    typing-extensions
    urllib3
  ];

  pythonImportsCheck = [
    "nethsm"
  ];

  pythonRelaxDeps = [
    "typing_extensions"
    "urllib3"
  ];
}
