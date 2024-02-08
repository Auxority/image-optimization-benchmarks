# Python 3.11.7
# MacBook M3 Pro - 36GB memory
# pillow 10.2.0 

import time
from PIL import Image

N_ITERATIONS = 10
INPUT_PATH = "./images/input/1.jpg"
OUTPUT_DIR = "./images/output"
COMPRESSED_QUALITY = 90

def load_image() -> Image:
    return Image.open(INPUT_PATH)

def test_cropping() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        cropped_image = im.crop((10, 10, 110, 110))
        cropped_image.save(f"{OUTPUT_DIR}/1-cropped.jpg")
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The cropping of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_compression() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        im.save(f"{OUTPUT_DIR}/1-compressed.jpg", 'JPEG', dpi=[300, 300], quality=COMPRESSED_QUALITY)
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The compression of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_resize() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        im_resized = im.resize((im.width // 2, im.height // 2))
        im_resized.save(f"{OUTPUT_DIR}/1-resized.jpg")
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The resizing of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_format_convert() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        im.save(f"{OUTPUT_DIR}/1-format.webp", 'WEBP', quality=100)
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The conversion of {N_ITERATIONS} images took {duration:.3f} seconds')

# test_cropping()
# Time in seconds for 10 iterations:
# 2.671
# 2.679
# 2.669
# 2.671
# 2.676

# test_compression()
# Time in seconds for 10 iterations:
# 4.700
# 4.745
# 4.739
# 4.776
# 4.746

# test_resize()
# Time in seconds for 10 iterations:
# 4.853
# 4.863
# 4.838
# 4.889
# 4.842

# test_format_convert()
# Time in seconds for 10 iterations:
# 33.092
# 33.176
# 33.531
# 33.411
# 33.960