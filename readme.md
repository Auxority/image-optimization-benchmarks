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
Open the `visualize.ipynb` file and run the cells to generate the data and visualizations.

# Conclusion
Based on five runs of the benchmarks, the following conclusions can be drawn:
Even though OpenCV scores high in many categories, it falls far behind during the `Convert` operation. FFmpeg isn't the greatest at anything, but is overall the best. But when you combine OpenCV and ImageMagick, it seems to be the fastest option.