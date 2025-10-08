#!/usr/bin/env bash

PID=$$

set -x
if [ "$1" == "" ] ; then
  echo "Please run $0 <domain>"
  exit 1;
fi

SERVER=$1

if [ -z $TMUX ] ; then
  echo "Start new tmux session"
  tmux new-session -d -s demo-$PID "watch curl -s -k https://sitea-frontend-frontend.${SERVER}/demo"
fi
tmux split-window -d -t 0 -v  "watch curl -s -k https://siteb-frontend-frontend.${SERVER}/demo"
tmux split-window -d -t 0 -h  "watch curl -s -k https://siteb-backend-backend.${SERVER}/demo"
tmux split-window -d -t 2 -h  "watch curl -s -k https://sitea-backend-backend.${SERVER}/demo"
if [ -z $TMUX ] ; then
  echo "Attach to session"
  tmux attach-session -t demo-$PID
else
  watch curl -s -k http://sitea-frontend-frontend.${SERVER}/demo
fi
