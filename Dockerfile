FROM registry.gitlab.com/xlab-steampunk/spotter-cli:main

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
