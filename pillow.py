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
            cropped_image = im.crop((10, 10, 522, 522))
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-crop{Path(image_path).suffix}"
            cropped_image.save(output_path, quality=100)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            filesize = os.path.getsize(output_path)
            original_filesize = os.path.getsize(image_path)
            print(f'crop {output_path} | Duration: {duration}, File size: {filesize} bytes')
            file.write(f'crop,{duration},{filesize},{original_filesize}\n')

def test_compress() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            extension = Path(image_path).suffix
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-compress{extension}"
            im.save(output_path, quality=COMPRESSED_QUALITY)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            filesize = os.path.getsize(output_path)
            original_filesize = os.path.getsize(image_path)
            print(f'compress {output_path} | Duration: {duration}, File size: {filesize} bytes')
            file.write(f'compress,{duration},{filesize},{original_filesize}\n')

def test_resize() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            im_resized = im.resize((im.width // 2, im.height // 2))
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-resize{Path(image_path).suffix}"
            im_resized.save(output_path, quality=100)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            filesize = os.path.getsize(output_path)
            original_filesize = os.path.getsize(image_path)
            print(f'resize {output_path} | Duration: {duration}, File size: {filesize} bytes')
            file.write(f'resize,{duration},{filesize},{original_filesize}\n')

def test_convert() -> None:
    image_paths = get_image_paths()
    with open(PERFORMANCE_FILE, "a") as file:
        for image_path in image_paths:
            start_time = time.perf_counter()
            im = Image.open(image_path)
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-convert.webp"
            im.save(output_path, 'WEBP', quality=100)
            stop_time = time.perf_counter()
            duration = stop_time - start_time
            filesize = os.path.getsize(output_path)
            original_filesize = os.path.getsize(image_path)
            print(f'convert {output_path} | Duration: {duration}, File size: {filesize} bytes')
            file.write(f'convert,{duration},{filesize},{original_filesize}\n')

test_crop()
test_compress()
test_resize()
test_convert()
