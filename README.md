# VR2AR Converter

Convert your adult VR Videos into Passthrough AR Videos. 

> [!NOTE]
> Currently this project only support Linux via [Nix package manager](https://nixos.org/download.html).

## Usage

### Convert

```sh
nix run github:michael-mueller-git/vr2ar-converter -- [VIDEO] [VR_INPUT_TYPE] 
```

When you use Nix on Linux you may have to wrapp the command into `nixGL` 

```sh
nix run --impure github:guibou/nixGL -- nix run github:michael-mueller-git/vr2ar-converter -- [VIDEO] [VR_INPUT_TYPE] 
```

### Consume Videos

To play the AR videos you can use [HereSphere](https://heresphere.com/) e.g. with Meta Quest 3.

Somtimes the video mode detection via filename in HereSphere is not working. Then you have to manually set the Settings:

- Basic Video Settings : Projection = `Fisheye` 
- Advanced Video Settings : True FOV: `[180,190,200]` (depending on vr type)
- Advanced Video Settings : Environment : Background = `Passthrough`
- Advanced Video Settings : Environment : Mask = `Alpha Packed`

Additional Settings:

- Basic Video Settings : Alignment : Right (Scale) - To adjust the model size
- Basic Video Settings : Origin : Forward - To adjust the depth position or use thub stick forward/backward to adjust this
- Basic Video Settings : Motion : Distance - To approx 50 to get better 6DoF experience.

Finally use controler grap to set the correct position of the model.
