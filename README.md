# Spam Mail Detection (backend)

Setup and run (Windows PowerShell):

1. Install Python from https://www.python.org/ and enable "Add Python to PATH".

2. From project root run:

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install --upgrade pip
pip install -r requirements.txt
```

3. Train the model (creates `spam_model.pkl` and `vectorizer.pkl`):

```powershell
python backend/train_model.py
```

4. Run the Flask server:

```powershell
python backend/app.py
```

Notes:
- If the model files are missing, the app still starts and will show a message prompting you to run the training script.
- Template is at `backend/frontend/templates/index.html`.

---

## Deployment

The code is available at `git@github.com:yuva1912/spam-app.git`.

### Render (recommended)

> **Note:** the `backend/` directory must be a Python package so that `backend.app` can be imported. An empty `__init__.py` file has been added.


Create a **Web Service** using the Git repo above.

- **Build Command:**
  ```bash
  pip install -r requirements.txt && pip install gunicorn && python backend/train_model.py || true
  ```
- **Start Command:**
  ```bash
  gunicorn backend.app:app --bind 0.0.0.0:$PORT
  ```
- Set `FLASK_SECRET` in the Render Dashboard under **Environment > Environment Variables**.

Optionally, switch to a [Docker service](https://render.com/docs/docker) and use the included `Dockerfile`:

```bash
docker build -t spam-app .
docker run --rm -p 8000:8000 -e FLASK_SECRET="your-secret" spam-app
```

### Heroku

```bash
heroku create your-app-name
heroku config:set FLASK_SECRET="your-secret"
git push heroku main
heroku ps:scale web=1
```

### Local Docker Test

```bash
docker build -t spam-app .
docker run --rm -p 8000:8000 -e FLASK_SECRET="your-secret" spam-app
curl http://localhost:8000/ping
```

---

The app exposes a `/ping` endpoint for health checks and uses `/api/predict` for programmatic access.  Environment variables should be used for secrets; do **not** rely on the fallback random key.
