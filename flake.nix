{
  description = "vr2ar-converter flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
      opencvGtk = pkgs.opencv.override (old : { enableGtk2 = true; });
      dependencies = [
        opencvGtk
        pkgs.ncnn
        pkgs.vulkan-headers
        pkgs.vulkan-loader
        pkgs.vulkan-tools
        pkgs.ffmpeg_6-full
        pkgs.vulkan-validation-layers
      ];
      shellDependencies = [
        pkgs.cmake
        pkgs.gcc
        pkgs.unzip
       (pkgs.python311.withPackages (p: with p; [
          torchvision
          pytorch
        ]))
      ];
      libPath = pkgs.lib.makeLibraryPath dependencies;
      binPath = pkgs.lib.makeBinPath dependencies;
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
          name = "vr2ar-converter";
          src = ./.;
          
          nativeBuildInputs = with pkgs; [
            cmake
            gcc
            makeWrapper
            unzip
          ];

          buildInputs = dependencies;

          configurePhase = ''
            export VULKAN_SDK=${pkgs.vulkan-loader}
            export VULKAN_INCLUDE_DIR=${pkgs.vulkan-headers}/include
            export VULKAN_LIBRARY=${pkgs.vulkan-loader}/lib/libvulkan.so
            export NCNN_INSTALL_DIR=${pkgs.ncnn}
            export OpenCV_DIR=${opencvGtk}
            export FFMPEG_PATH=${pkgs.ffmpeg_6-full}/bin/ffmpeg
            cmake -B build -S .
          '';

          buildPhase = ''
            cmake --build build
          '';

          installPhase = ''
            mkdir -p $out/bin
            cp build/vr2ar-converter $out/bin/
            cp -f files/mask.png $out/bin/
            unzip files/mobilenetv3.zip -d $out/bin/
            unzip files/resnet50.zip -d $out/bin/
            echo "$out/bin/"
            wrapProgram "$out/bin/vr2ar-converter" --prefix LD_LIBRARY_PATH : "${libPath}" --prefix PATH : "${binPath}" --add-flags "--ffmpeg-path ${pkgs.ffmpeg_6-full}/bin/ffmpeg"
          '';
        };
      formatter.${system} = pkgs.nixpkgs-fmt;
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = (dependencies ++ shellDependencies);
        shellHook = ''
            export VULKAN_SDK=${pkgs.vulkan-loader}
            export VULKAN_INCLUDE_DIR=${pkgs.vulkan-headers}/include
            export VULKAN_LIBRARY=${pkgs.vulkan-loader}/lib/libvulkan.so
            export NCNN_INSTALL_DIR=${pkgs.ncnn}
            export OpenCV_DIR=${opencvGtk}
            export FFMPEG_PATH=${pkgs.ffmpeg_6-full}/bin/ffmpeg
          '';
      };
    };
}
