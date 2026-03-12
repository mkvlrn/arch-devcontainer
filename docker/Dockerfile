FROM archlinux:base AS base
ARG BASE_IMAGE=archlinux:base
COPY ./install.sh /tmp/
COPY .config/ /tmp/.config/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
COPY ./docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

ENTRYPOINT ["/usr/local/bin/docker-init.sh"]
CMD ["sleep", "infinity"]