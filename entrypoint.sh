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

  [[ ! -d ~/.ssh ]] && mkdir /root/.ssh

  ssh-keyscan github.com >> /root/.ssh/known_hosts

  ssh-add <(echo "$sshKey")

fi

# Working Directory
workingDirectory=$4

set +e
if [[ -n $workingDirectory ]]; then
  if [[ -d $workingDirectory ]]; then
    cd "$workingDirectory"
  else
    echo "ERROR: working-directory $workingDirectory does not exist"
    exit 1
  fi
fi

set -e

# Log the actions
set -x

clojure $j_Opts $a_Opts
