FROM python:3.7-slim AS base

WORKDIR /usr/src/app
RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install libmagic-dev libxml2

FROM base AS env

COPY Pipfile* ./
RUN apt-get update && apt-get upgrade -y && \
    apt-get -y install build-essential && \
    python -m venv .venv && \
    export PATH="/.venv/bin:$PATH" && \
    pip install pipenv && \
    pipenv install --deploy --ignore-pipfile && \
    apt-get -y remove build-essential && apt-get clean

FROM base AS runtime

COPY --from=env /usr/src/app/.venv /.venv
ENV PATH="/.venv/bin:$PATH"

EXPOSE 8080
EXPOSE 3306
COPY python_flask ./python_flask
ENTRYPOINT python -m python_flask.app
