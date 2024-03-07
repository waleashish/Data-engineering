FROM python:3

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2

WORKDIR /app

COPY Data_injestion.py Data_injestion.py

ENTRYPOINT [ "python", "Data_injestion.py" ]