#!/usr/bin/env python

#https://github.com/python-pillow/Pillow/issues/4903
#https://stackoverflow.com/questions/9166400/convert-rgba-png-to-rgb-with-pil
#https://stackoverflow.com/questions/50763236/converting-png-to-pdf-with-pil-save-mode-error

from PIL import Image

PNG_FILE = 'pwband.png'
PDF_FILE = 'pwband.pdf'

rgba = Image.open(PNG_FILE)
rgb = Image.new('RGB', rgba.size, (255, 255, 255))  # white background
rgb.paste(rgba, mask=rgba.split()[3])               # paste using alpha channel as mask
rgb.save(PDF_FILE, 'PDF', resoultion=600.0)




