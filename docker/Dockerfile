FROM archlinux:base

COPY ./install.sh /tmp/
RUN /tmp/install.sh
USER dev
WORKDIR /home/dev
COPY --chown=dev:dev ./mkvlrn.omp.json ./.config/
COPY --chown=dev:dev ./.zshrc ./
