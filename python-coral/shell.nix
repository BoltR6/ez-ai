{ pkgs ? import <nixpkgs> {} }:
let
  system = "linux_x86_64";
	python-package-list = p: with p; [
    pip
    numpy
    (
      buildPythonPackage rec {
        pname = "opencv-python";
        version = "4.7.0.68";
        format = "wheel";
        src = pkgs.fetchurl {
          name = "opencv_python-4.7.0.68-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
          url = "https://files.pythonhosted.org/packages/07/e2/405fd71f433960b0ce6a546536b05a26d85508df7eea98850784e10323e9/opencv_python-4.7.0.68-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
          sha256 = "sha256-OgDhJUblV49rt+1AjDf8/qUz106Wkc+vQJJva0MpVXc=";
        };
        doCheck = false;
        propagatedBuildInputs = [
          # Specify dependencies
          pkgs.python38Packages.numpy
        ];
      }
    )
    (
      buildPythonPackage rec {
        pname = "pycoral";
        version = "2.0.0";
        format = "wheel";
        src = pkgs.fetchurl {
          name = "pycoral-${version}-cp38-cp38-${system}.whl";
          url = "https://github.com/google-coral/pycoral/releases/download/v2.0.0/pycoral-2.0.0-cp38-cp38-linux_x86_64.whl";
          sha256 = "sha256-erRyNHGNzvPF+T3kYA4/rn9k7BiG0MxK3CJv8KnbcF4=";
        };
        doCheck = false;
        propagatedBuildInputs = [
          # Specify dependencies
          (
            buildPythonPackage rec {
              pname = "Pillow";
              version = "7.1.0";
              format = "wheel";
              src = pkgs.fetchurl {
                name = "Pillow-7.1.0-cp38-cp38-manylinux1_x86_64.whl";
                url = "https://files.pythonhosted.org/packages/55/5d/f22d026c891bcb22008eb309cb9e2bf61eaad254a70bdaaeda06386cf505/Pillow-7.1.0-cp38-cp38-manylinux1_x86_64.whl";
                sha256 = "sha256-+x+fqimEkYzXo7GNsRkkY+ADBQDLBgyXS1/ZjBMnao4=";
              };
              doCheck = false;
              propagatedBuildInputs = [
                # Specify dependencies
              ];
            }
          )
          (
            buildPythonPackage rec {
              pname = "tflite-runtime";
              version = "2.5.0.post1";
              format = "wheel";
              src = pkgs.fetchurl {
                name = "tflite_runtime-2.5.0.post1-cp38-cp38-linux_x86_64.whl";
                url = "https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp38-cp38-linux_x86_64.whl";
                sha256 = "sha256-JdmvMK0My/GByYaLI2izS8leO1am53Ueu7hNPsqwk5M=";
              };
              doCheck = false;
              propagatedBuildInputs = [
                # Specify dependencies
                pkgs.python38Packages.numpy
              ];
            }
          )
        ];
      }
    )
  ];
  ai-python = pkgs.python38.withPackages python-package-list;
in
  pkgs.mkShell {
    nativeBuildInputs = with pkgs; [
		  ai-python
    ];
	shellHook =
		''
    sed -i 's/\r$//' shell.nix
    echo "hiii :)"
		'';
}