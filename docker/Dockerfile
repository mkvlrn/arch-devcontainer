FROM archlinux:base AS base
ARG BASE_IMAGE=archlinux:base
COPY ./install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
COPY --chown=dev:dev ./.zshrc ./mkvlrn.omp.json /home/dev/
COPY ./docker-init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-init.sh

ENTRYPOINT ["/usr/local/bin/docker-init.sh"]
CMD ["sleep", "infinity"]