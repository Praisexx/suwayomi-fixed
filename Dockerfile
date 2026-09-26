FROM ghcr.io/suwayomi/tachidesk

USER root

COPY fix-perms-entrypoint.sh /usr/local/bin/fix-perms-entrypoint.sh
RUN chmod +x /usr/local/bin/fix-perms-entrypoint.sh

ENTRYPOINT ["tini", "--", "/usr/local/bin/fix-perms-entrypoint.sh"]
