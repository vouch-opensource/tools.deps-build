#!/usr/bin/env bash

set -e

# Use :test as the default alias
aliases=${1:-":test"}

a_Opts="-A$aliases"

# Java opts
javaOpts=$2

j_Opts=""

if [[ -n $javaOpts ]]
then
  # Split Java opts into an array and prepend -J to each opt
  read -ra optsArray <<< $javaOpts
  j_Opts=$(for j in "${optsArray[@]}" ; do echo "-J$j" ; done)
fi

# SSH key
sshKey=$3

if [[ -n $sshKey ]]
then

  eval "$(ssh-agent -s)"

  [[ ! -d ~/.ssh ]] && mkdir ~/.ssh

  ssh-keyscan github.com >> ~/.ssh/known_hosts

  SSH_KEY=~/.ssh/github_rsa

  echo $sshKey > $SSH_KEY
  chmod 600 $SSH_KEY
  ssh-add $SSH_KEY

fi

# Log the actions
set -x

clojure $j_Opts $a_Opts