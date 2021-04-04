FROM python:3
WORKDIR /app
COPY . /app
ENV APP_SETTINGS=config.DevelopmentConfig
RUN pip install -r requirements.txt
EXPOSE 5000
CMD python3 app.py
