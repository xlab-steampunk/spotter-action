FROM registry.gitlab.com/xlab-steampunk/steampunk-spotter-client/spotter-cli:1.2.0

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
