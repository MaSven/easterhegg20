#!/bin/sh

if [ -z "$1" ]; then
  echo "Please provide a file path for --find-file"
  exit 1
fi

emacs --no-init-file --user="${USER}" --batch --eval="(require 'org)" --eval="(require 'ox-reveal)" --find-file="$1" --funcall="org-reveal-export-to-html"
