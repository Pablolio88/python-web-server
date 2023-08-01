FROM python:slim-bookworm

RUN apt-get update && \
    apt-get clean

EXPOSE 8080/tcp
COPY Python /app/python_web_server

WORKDIR /app/python_web_server
RUN pip install -r requirements.txt

CMD [ "python3", "server.py" ]