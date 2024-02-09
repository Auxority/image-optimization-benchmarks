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
            im = Image.open(image_path)
            cropped_image = im.crop((10, 10, 110, 110))
            cropped_image.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-crop{Path(image_path).suffix}")
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            print(f'{OUTPUT_DIR}/{Path(image_path).stem}-crop{Path(image_path).suffix} {duration}')
            file.write(f'{duration}\n')

def test_compress() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            extension = Path(image_path).suffix
            im.save(
                f"{OUTPUT_DIR}/{Path(image_path).stem}-compress{extension}",
                quality=COMPRESSED_QUALITY
            )
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            print(f'{OUTPUT_DIR}/{Path(image_path).stem}-compress{Path(image_path).suffix} {duration}')
            file.write(f'{duration}\n')

def test_resize() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im_resized = im.resize((im.width // 2, im.height // 2))
            im_resized.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-resize{Path(image_path).suffix}")
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            print(f'{OUTPUT_DIR}/{Path(image_path).stem}-resize{Path(image_path).suffix} {duration}')
            file.write(f'{duration}\n')

def test_convert() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im.save(f"{OUTPUT_DIR}/{Path(image_path).stem}-convert.webp", 'WEBP', quality=100)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            print(f'{OUTPUT_DIR}/{Path(image_path).stem}-convert.webp {duration}')
            file.write(f'{duration}\n')

test_crop()
test_compress()
test_resize()
test_convert()
