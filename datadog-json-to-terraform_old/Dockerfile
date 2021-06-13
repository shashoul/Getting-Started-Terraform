FROM ubuntu

WORKDIR /app

COPY /src .

RUN apt-get update && apt-get install -y python3 python3-pip

COPY requirements.txt .

RUN pip3 install -r requirements.txt

ENTRYPOINT [ "python3","main.py" ]

CMD [ "--help" ]