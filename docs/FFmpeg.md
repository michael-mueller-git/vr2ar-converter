# FFmpeg

Image to video:

```sh
ffmpeg -loop 1 -i in.jpg -c:v libx265 -t 1 out.mp4
```

`- t` specify the video length. In this case 1 second.
