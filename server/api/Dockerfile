FROM python:3.5

ADD requirements.txt .
ADD Sources/* ./

RUN pip install -r requirements.txt

CMD python api.py
