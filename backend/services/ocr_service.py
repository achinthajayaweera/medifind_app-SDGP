import os
import json
import time
import re
from pathlib import Path
from typing import Optional, List

import easyocr
from PIL import Image, ImageEnhance, ImageFilter

# -- EasyOCR Reader (lazy singleton) --
_easyocr_reader = None

def _get_easyocr_reader():
    global _easyocr_reader
    if _easyocr_reader is None:
        _easyocr_reader = easyocr.Reader(['en'], gpu=False, verbose=False)
    return _easyocr_reader
