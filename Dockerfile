FROM python:3.7 as base

FROM base as builder 
RUN mkdir /install
RUN apt-get update
# && apt-get install postgresql-dev gcc musl-dev cargo
WORKDIR /install
COPY requirements.txt /requirements.txt
RUN pip3 install --prefix=/install -r /requirements.txt  

FROM base
COPY --from=builder /install /usr/local
RUN pip install alembic python-dateutil
# RUN apt-get update && apt-get install libpq
ADD . /app
WORKDIR /app
EXPOSE 9090
CMD ["./start.sh"]
