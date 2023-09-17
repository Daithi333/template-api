FROM python:3.11.2-alpine as builder

#### Variables used to authenicate pip to install private libs
ARG CRYPTOGRAPHY_DONT_BUILD_RUST=1
ARG PIPENV_VENV_IN_PROJECT=1

WORKDIR /opt/app-root/

USER 0

# remove important vulnerabilities
RUN apk update && apk upgrade

RUN pip install pipenv==2023.2.18

#### Install dependencies
COPY Pipfile            ./Pipfile
COPY Pipfile.lock       ./Pipfile.lock

RUN pipenv install --deploy

FROM python:3.11.2-alpine

ARG user=1001

ENV PATH="/opt/app-root/.venv/bin:$PATH"
ENV PYTHONPATH="${PYTHONPATH}:/opt/app-root/src"

### Add package needs here

WORKDIR /opt/app-root

COPY --from=builder /opt/app-root/.venv /opt/app-root/.venv

COPY ./src              /opt/app-root/src
COPY docker/cmds        /opt/app-root

RUN chown -R ${user}:0 /opt/app-root

USER ${user}

CMD ./start_server.sh
