#!/bin/bash
nohup jupyter-lab \
    --no-browser \
    --allow-root \
    --ip=0.0.0.0 \
    --NotebookApp.token='' \
    --NotebookApp.notebook_dir="${NOTEBOOK_HOME}" \
    --NotebookApp.allow_origin="*" > /dev/null 2>&1 &

echo "jupyter-lab server started on port 8888."

exec $@