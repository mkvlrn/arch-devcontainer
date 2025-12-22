FROM archlinux:base AS base
COPY ./install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
RUN mkdir -p /home/dev/.config/zsh && chown dev:dev /home/dev/.config/zsh
COPY --chown=dev:dev ./*.zsh /home/dev/.config/zsh/
COPY --chown=dev:dev ./mkvlrn.omp.json /home/dev/.config/zsh/
COPY --chown=dev:dev ./.zshrc /home/dev/
COPY ./git-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/git-setup.sh
RUN pacman -Scc --noconfirm && \
    su dev -c "yay -Scc --noconfirm" && \
    rm -rf /var/cache/pacman/pkg/* /home/dev/.cache/yay/* /tmp/*
USER dev
WORKDIR /home/dev