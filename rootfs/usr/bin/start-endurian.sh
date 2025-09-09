#!/bin/bash
set -e

echo "=== Endurian Startup Script ==="
echo "Current user: $(whoami)"
echo "Current directory: $(pwd)"
echo "Python path: $(/opt/venv/bin/python -c 'import sys; print(sys.executable)')"

echo "=== Environment Variables ==="
env | grep -E "(POSTGRES|LOG_LEVEL|DEBUG|BIND|WORKERS)" || echo "No matching env vars found"

echo "=== Virtual Environment Check ==="
/opt/venv/bin/python --version
/opt/venv/bin/python -c "import sys; print('Python executable:', sys.executable)"

echo "=== Installed Packages ==="
/opt/venv/bin/python -c "import pkg_resources; [print(d) for d in pkg_resources.working_set]" | head -10

echo "=== FastAPI App Check ==="
if [ -f "/app/backend/main.py" ]; then
    echo "main.py exists"
    head -20 /app/backend/main.py
else
    echo "main.py not found!"
    echo "Backend directory contents:"
    ls -la /app/backend/
    exit 1
fi

echo "=== Starting uvicorn ==="
cd /app/backend
exec /opt/venv/bin/python -m uvicorn main:app \
    --host "${BIND_HOST:-0.0.0.0}" \
    --port "${BIND_PORT:-8080}" \
    --log-level "${LOG_LEVEL:-info}" \
    --access-log
