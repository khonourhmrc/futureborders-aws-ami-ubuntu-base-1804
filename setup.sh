#!/bin/bash

set -ex 

[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"
export PATH=~/.local/bin:$PATH