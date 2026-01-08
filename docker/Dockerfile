FROM archlinux:base AS base
COPY ./install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
RUN mkdir -p /home/dev/.config/zsh && chown dev:dev /home/dev/.config/zsh
COPY --chown=dev:dev ./*.zsh ./mkvlrn.omp.json /home/dev/.config/zsh/
COPY --chown=dev:dev ./.zshrc /home/dev/
COPY --chmod=755 ./git-setup.sh /usr/local/bin/
USER dev
WORKDIR /home/dev