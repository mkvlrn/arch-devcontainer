FROM archlinux:base

COPY ./install.sh /tmp/
RUN /tmp/install.sh
USER dev
WORKDIR /home/dev
COPY --chown=dev:dev ./.zshrc ./
