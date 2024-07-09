FROM python:3.9-alpine
ENV PYTHONUNBUFFERED=1
RUN apk add --no-cache gcc musl-dev linux-headers
WORKDIR /app
COPY static/ templates/ app.py requirements.txt /app/
COPY templates/ /app/templates/
COPY static/ /app/static/
COPY app.py requirements.txt  /app/
RUN ls -la /app/*
RUN ls -la /app/templates/*
RUN ls -la /app/static/*
RUN apk add --no-cache --virtual .build-deps \
    build-base \
    && pip install --no-cache-dir flask requests \
    && apk del .build-deps
EXPOSE 5000
CMD ["python", "app.py"]

