# VR2AR Converter

Convert your adult VR Videos into Passthrough AR Videos. 

> [!NOTE]
> Currently this project only support Linux via [Nix package manager](https://nixos.org/download.html).

## Usage

```sh
nix run github:michael-mueller-git/vr2ar-converter -- [VIDEO] [VR_INPUT_TYPE] 
```

When you use Nix on Linux you may have to wrapp the command into `nixGL` 

```sh
nix run --impure github:guibou/nixGL -- nix run github:michael-mueller-git/vr2ar-converter -- [VIDEO] [VR_INPUT_TYPE] 
```
