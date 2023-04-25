FROM registry.gitlab.com/xlab-steampunk/steampunk-spotter-client/spotter-cli:1.2.6

ENTRYPOINT ["/entrypoint.sh"]

COPY entrypoint.sh /entrypoint.sh
