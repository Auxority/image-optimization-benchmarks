# Setup
- Make sure to install Python (3.11.7)

- Then make sure to install vips, ffmpeg, imagemagick, and graphicsmagick.

```sh
brew install vips ffmpeg imagemagick graphicsmagick
```

- And make sure to install the required python dependencies.

```sh
pip install -r requirements.txt
```

# Running the tests:
```sh
./ffmpeg.sh
./graphicsmagick.sh
./imagemagick.sh
./libvips.sh
python3 ./pillow.py
python3 ./opencv.py
```

The results will be outputted to the results directory.