# syntax=docker/dockerfile:1
FROM python:3


# ENV PYTHONPATH "${PYTHONPATH}:./"
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# RUN mkdir /kepler_cafe
WORKDIR /kepler_cafe
# WORKDIR /kepler_cafe
# ADD requirements.txt /developing/
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
# ADD . /developing