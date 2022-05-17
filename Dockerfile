FROM python:3

RUN pip install mariadb

COPY app-python/ /usr/src/app/

CMD ["python", "/usr/src/app/main.py"]
