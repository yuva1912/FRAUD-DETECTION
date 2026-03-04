import os
import sys

# Ensure repo root is on sys.path
ROOT = os.path.dirname(__file__)
if ROOT not in sys.path:
    sys.path.insert(0, ROOT)

# Import the Flask app from backend
from backend.app import app
