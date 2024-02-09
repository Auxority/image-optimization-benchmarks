# Python 3.11.7
# MacBook M3 Pro - 36GB memory
# opencv-python 4.9.0.80 

import time
import cv2
import os
from pathlib import Path

INPUT_DIR = "./images/input"
OUTPUT_DIR = "./images/output"
PERFORMANCE_FILE = "./results/opencv-results.txt"
COMPRESSED_QUALITY = 90

def get_image_paths():
    image_paths = []
    for filename in os.listdir(INPUT_DIR):
        if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.webp')):
            image_path = os.path.join(INPUT_DIR, filename)
            image_paths.append(image_path)
    image_paths.sort()
    return image_paths

def test_crop() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = cv2.imread(image_path)
            cropped_image = im[10:110, 10:110]
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-crop{Path(image_path).suffix}"
            cv2.imwrite(output_path, cropped_image)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_compress() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = cv2.imread(image_path)
            output_path = f'{OUTPUT_DIR}/{Path(image_path).stem}-compress{Path(image_path).suffix}'
            cv2.imwrite(output_path, im, [cv2.IMWRITE_JPEG_QUALITY, COMPRESSED_QUALITY])
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_resize() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = cv2.imread(image_path)
            new_dimensions = (len(im[0]) // 2, len(im) // 2)
            im_resized = cv2.resize(im, new_dimensions)
            output_path = f'{OUTPUT_DIR}/{Path(image_path).stem}-resize{Path(image_path).suffix}'
            cv2.imwrite(output_path, im_resized)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_convert() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = cv2.imread(image_path)
            cv2.imwrite(f'{OUTPUT_DIR}/{Path(image_path).stem}-convert.webp', im)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

test_crop()
test_compress()
test_resize()
test_convert()
