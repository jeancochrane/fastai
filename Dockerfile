FROM python:3.6.7-slim-jessie

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

COPY . /usr/local/src
CMD ["jupyter", "notebook"]
