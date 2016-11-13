FROM python:3.5

ADD grabber.py .
ADD config.yml .
ADD requirements.txt .

RUN pip install -r requirements.txt

CMD python grabber.py

