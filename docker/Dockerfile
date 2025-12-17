FROM archlinux:base AS base
COPY base/install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
RUN mkdir -p /home/dev/.config/zsh && chown dev:dev /home/dev/.config/zsh
COPY --chown=dev:dev base/*.zsh /home/dev/.config/zsh/

FROM base AS intermediate
ARG VARIANT
COPY ${VARIANT}/install.sh /tmp/
RUN chmod +x /tmp/install.sh && /tmp/install.sh
COPY --chown=dev:dev ${VARIANT}/*.zsh /home/dev/.config/zsh/
COPY --chown=dev:dev ./mkvlrn.omp.json /home/dev/.config/zsh/
COPY --chown=dev:dev ./.zshrc /home/dev/

FROM intermediate AS final
RUN pacman -Scc --noconfirm && \
    su dev -c "yay -Scc --noconfirm" && \
    rm -rf /var/cache/pacman/pkg/* /home/dev/.cache/yay/* /tmp/*
USER dev
WORKDIR /home/dev