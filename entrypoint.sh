#!/usr/bin/env bash

set -e

# Use :test as the default alias
aliases=${1:-":test"}
javaOpts=$2

a_Opts="-A$aliases"
j_Opts=""

if [[ -n $javaOpts ]]
then
  # Split Java opts into an array and prepend -J to each opt
  read -ra optsArray <<< $javaOpts
  j_Opts=$(for j in "${optsArray[@]}" ; do echo "-J$j" ; done)
fi

# Log the actions
set -x

clojure $j_Opts $a_Opts