FROM registry.gitlab.com/xlab-steampunk/steampunk-spotter-client/spotter-cli:6.4.1

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
