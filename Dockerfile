FROM registry.gitlab.com/xlab-steampunk/steampunk-spotter-client/spotter-cli:5.1.1

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
