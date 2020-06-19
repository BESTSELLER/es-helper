#!/bin/bash

FILES=/policies/*
for f in $FILES
do
  if [[ $(echo $f | awk -F'.' '{print $2}') -gt $( echo $1 | awk -F'.' '{print $2}') ]];
  then
    # replace deny with warn
    sed -i 's/deny/warn/g' $f
  fi
  
done