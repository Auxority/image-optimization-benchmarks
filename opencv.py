# Python 3.11.7
# MacBook M3 Pro - 36GB memory
# opencv-python 4.9.0.80 

import time
import cv2

N_ITERATIONS = 10
INPUT_PATH = "./images/input/1.jpg"
OUTPUT_DIR = "./images/output"
COMPRESSED_QUALITY = 90

def load_image():
    return cv2.imread(INPUT_PATH)

def test_cropping() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        cropped_image = im[10:110, 10:110]
        cv2.imwrite(f"{OUTPUT_DIR}/1-cropped.jpg", cropped_image)
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The cropping of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_compression() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        cv2.imwrite(f'{OUTPUT_DIR}/1-compressed.jpg', im, [cv2.IMWRITE_JPEG_QUALITY, COMPRESSED_QUALITY])
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The compression of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_resize() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        new_dimensions = (len(im[0]) // 2, len(im) // 2)
        im_resized = cv2.resize(im, new_dimensions)
        cv2.imwrite(f'{OUTPUT_DIR}/1-resized.jpg', im_resized)
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The resizing of {N_ITERATIONS} images took {duration:.3f} seconds')

def test_format_convert() -> None:
    start_time = time.perf_counter()
    for i in range(N_ITERATIONS):
        im = load_image()
        cv2.imwrite(f'{OUTPUT_DIR}/1-format.webp', im)
    stop_time = time.perf_counter()
    duration = stop_time - start_time
    print(f'The conversion of {N_ITERATIONS} images took {duration:.3f} seconds')

# test_cropping()
# Time in seconds for 10 iterations:
# 2.041
# 2.072
# 2.065
# 2.066
# 2.057
    
# test_compression()
# Time in seconds for 10 iterations:
# 2.712
# 2.724
# 2.718
# 2.713
# 2.752
    
# test_resize()
# Time in seconds for 10 iterations:
# 2.288
# 2.287
# 2.287
# 2.297
# 2.317

# test_format_convert()
# Time in seconds for 10 iterations:
# 134.731
# 136.419
# 135.692
# 136.200
# 135.913