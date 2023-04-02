FROM nixos/nix

ADD https://api.github.com/repos/purcell/nix-emacs-ci/git/refs/heads/master /tmp/cache
RUN nix-env -iA cachix -f https://cachix.org/api/v1/install
RUN cachix use emacs-ci
RUN nix-env -iA emacs-28-2 -f https://github.com/purcell/nix-emacs-ci/archive/master.tar.gz
RUN nix --extra-experimental-features nix-command copy --no-require-sigs --to /nix-emacs $(type -p emacs)
RUN cd /nix-emacs/nix/store && ln -s *emacs* emacs

FROM debian

RUN apt-get update && \
    apt-get install -y \
            curl \
            gnupg \
            openssh-client \
            git \
    && rm -rf /var/lib/apt/lists/*

COPY --from=0 /nix-emacs/nix/store /nix/store
#COPY .doom.d /root/.doom.d
ENV PATH="/nix/store/emacs/bin:$PATH"

#RUN git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
#RUN ~/.config/emacs/bin/doom sync

RUN emacs \
 --no-init-file  \
 --user="${USER}" \
 --batch \
 --eval="(require 'package)" \
 --eval="(add-to-list 'package-archives \
  '(\"melpa\" . \"https://melpa.org/packages/\"))" \
 --eval='(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")' \
 --eval="(package-initialize)" \
 --eval="(package-show-package-list)" \
 --eval="(package-refresh-contents)" \
 --eval="(package-list-packages)" \
 --eval="(package-install 'org)" \
 --eval="(package-install 'htmlize)" \
 --eval="(package-install 'docker)" \
 --eval="(package-install 'ox-reveal)"


# Copy the entrypoint.sh script to the container
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Set the ENTRYPOINT to use the script
ENTRYPOINT ["/entrypoint.sh"]
