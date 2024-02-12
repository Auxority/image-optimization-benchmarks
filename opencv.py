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
            cropped_image = im[10:138, 10:138]
            output_path = f"{OUTPUT_DIR}/{Path(image_path).stem}-crop{Path(image_path).suffix}"
            cv2.imwrite(output_path, cropped_image, [
                cv2.IMWRITE_PNG_COMPRESSION, 0,
                cv2.IMWRITE_JPEG_QUALITY, 100
            ])
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
            im = cv2.imread(image_path)
            output_path = f'{OUTPUT_DIR}/{Path(image_path).stem}-compress{Path(image_path).suffix}'
            cv2.imwrite(output_path, im, [
                cv2.IMWRITE_JPEG_QUALITY, COMPRESSED_QUALITY,
                cv2.IMWRITE_PNG_COMPRESSION, 3,
            ])
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
            im = cv2.imread(image_path)
            new_dimensions = (len(im[0]) // 2, len(im) // 2)
            im_resized = cv2.resize(im, new_dimensions)
            output_path = f'{OUTPUT_DIR}/{Path(image_path).stem}-resize{Path(image_path).suffix}'
            cv2.imwrite(output_path, im_resized, [
                cv2.IMWRITE_PNG_COMPRESSION, 0,
                cv2.IMWRITE_JPEG_QUALITY, 100
            ])
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
            im = cv2.imread(image_path)
            output_path = f'{OUTPUT_DIR}/{Path(image_path).stem}-convert.webp'
            cv2.imwrite(output_path, im, [
                cv2.IMWRITE_PNG_COMPRESSION, 0,
                cv2.IMWRITE_JPEG_QUALITY, 100
            ])
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
