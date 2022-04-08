#!/usr/bin/env zsh

# mkcd is equivalent to take
function mkcd take() {
  mkdir -p $@ && cd ${@:$#}
}