# Based on:
# https://github.com/NixOS/nixpkgs/blob/b84f55850ada9b306653cb2f3b768078ce46a9ed/pkgs/development/tools/misc/nrfutil/default.nix

{
  python3,
  fetchFromGitHub,
  pc-ble-driver-py,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "nrfutil";
  version = "6.1.7";

  src = fetchFromGitHub {
    owner = "NordicSemiconductor";
    repo = "pc-nrfutil";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-WiXqeQObhXszDcLxJN8ABd2ZkxsOUvtZQSVP8cYlT2M=";
  };

  propagatedBuildInputs =
    with python3.pkgs;
    [
      click
      crcmod
      ecdsa
      libusb1
      intelhex
      piccata
      protobuf
      pyserial
      pyspinel
      pyyaml
      tqdm
    ]
    ++ [ pc-ble-driver-py ];

  nativeCheckInputs = with python3.pkgs; [
    behave
    pytestCheckHook
  ];

  # Workaround: pythonRelaxDepsHook doesn't work for this.
  postPatch = ''
    mkdir test-reports
    substituteInPlace requirements.txt \
      --replace "libusb1==1.9.3" "libusb1" \
      --replace "protobuf >=3.17.3, < 4.0.0" "protobuf"
    substituteInPlace nordicsemi/dfu/tests/test_signing.py \
      --replace "self.assertEqual(expected_vk_pem, vk_pem)" ""
  '';

  preCheck = ''
    export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
  '';

  makeWrapperArgs = [
    "--set"
    "PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION"
    "python"
  ];
}
