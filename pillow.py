# Python 3.11.7
# MacBook M3 Pro - 36GB memory
# opencv-python 4.9.0.80 

import time
import os
from pathlib import Path
from PIL import Image

INPUT_DIR = "./images/input"
OUTPUT_DIR = "./images/output"
PERFORMANCE_FILE = "./results/pillow-results.txt"
COMPRESSED_QUALITY = 90

def get_image_paths():
    image_paths = []
    for filename in os.listdir(INPUT_DIR):
        if filename.endswith(".jpg") or filename.endswith(".jpeg") or filename.endswith(".png"):
            image_path = os.path.join(INPUT_DIR, filename)
            image_paths.append(image_path)
    image_paths.sort()
    return image_paths

def test_crop() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            cropped_image = im.crop((10, 10, 110, 110))
            cropped_image.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-cropped.jpg")
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_compress() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-compressed.jpg", 'JPEG', quality=COMPRESSED_QUALITY)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_resize() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im_resized = im.resize((im.width // 2, im.height // 2))
            im_resized.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-resized.jpg")
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

def test_convert() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-format.webp", 'WEBP', quality=100)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            file.write(f'{duration}\n')

test_crop()
test_compress()
test_resize()
test_convert()
