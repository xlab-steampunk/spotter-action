FROM python:3.10-slim-buster

# copy files
COPY entrypoint.sh /entrypoint.sh

# make script executable and install requirements
RUN chmod +x /entrypoint.sh \
    && pip install --upgrade pip wheel \
    && pip install steampunk-spotter

# set main entrypoint
ENTRYPOINT ["/entrypoint.sh"]
