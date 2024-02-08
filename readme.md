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

# Results
You can use the `visualize.ipynb` Jupyter Notebook to generate the visualizations of the results.

# Conclusion
Even though OpenCV scores high in many categories, it falls far behind during the `Convert` operation. FFmpeg isn't the greatest at anything, but is overall the best.