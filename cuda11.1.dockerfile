FROM pytorch/pytorch:1.8.0-cuda11.1-cudnn8-runtime
LABEL maintainer="Nils Reimers <info@nils-reimers>"

###################################### Same code for all docker files ###############

## Install dependencies
RUN apt-get update && apt-get -y install build-essential
RUN pip install --no-cache-dir "uvicorn[standard]" gunicorn fastapi
COPY docker/api/requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt
## TODO: del easynmt from requirements and install local
## RUN pip install -e .
RUN python -m nltk.downloader 'punkt'

#### Scripts to start front- and backend worker

COPY docker/api/start_backend.sh /start_backend.sh
RUN chmod +x /start_backend.sh

COPY docker/api/start_frontend.sh /start_frontend.sh
RUN chmod +x /start_frontend.sh

COPY docker/api/start.sh /start.sh
RUN chmod +x /start.sh

COPY docker/api/gunicorn_conf_backend.py /gunicorn_conf_backend.py
COPY docker/api/gunicorn_conf_frontend.py /gunicorn_conf_frontend.py

#### Woking dir

COPY docker/api/src /app
WORKDIR /app/
ENV PYTHONPATH=/app
EXPOSE 80

####

# Create cache folders
RUN mkdir /cache/
RUN mkdir /cache/easynmt
RUN mkdir /cache/transformers
RUN mkdir /cache/torch

ENV EASYNMT_CACHE=/cache/easynmt
ENV TRANSFORMERS_CACHE=/cache/transformers
ENV TORCH_CACHE=/cache/torch

# Run start script
CMD ["/start.sh"]



