FROM registry.gitlab.com/xlab-steampunk/steampunk-spotter-client/spotter-cli:1.1.10

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
