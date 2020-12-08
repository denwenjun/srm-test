#!/usr/bin/env bash
#version: v1.0
#author: Shijie Qin
#license: Apache Licence
#contact: qsj4work@gmail.com
#site: https://shijieqin.github.io
#software: vim
#time: 2019/05/14 15:33
# -----------------------------------------------------------------------------
# Control Script for the CATALINA Server
#
# Environment Variable Prerequisites
#
#   Do not set the variables in this script. Instead put them into a script
#   setenv.sh in CATALINA_BASE/bin to keep your customizations separate.
#
#   APP_HOME   May point at your APP "build" directory.
#
#
#   APP_OUT    (Optional) Full path to a file where stdout and stderr
#                   Default is $APP_HOME/logs/catalina.out
#
# -----------------------------------------------------------------------------
SLEEP=5
SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
APP_HOME=`dirname $DIR`
#echo $APP_HOME

if [ -r "$APP_HOME/bin/setenv.sh" ]; then
  . "$APP_HOME/bin/setenv.sh"
fi

if [ -z "$APP_OUT" ] ; then
  APP_OUT="$APP_HOME"/logs/app.out
fi

if jps -ml | grep $JAR ; then
  PID=$(jps -ml | grep $JAR | awk '{print $1}')
  kill $PID
  while [ $SLEEP -ge 0 ]; do
    kill -0 $PID
    if [ $? -gt 0 ]; then
      echo "APP APP stopped."
      break
    fi
    if [ $SLEEP -gt 0 ]; then
      sleep 1
    fi
    if [ $SLEEP -eq 0 ]; then
      echo "APP did not stop in time."
      echo "Try to kill -9 $PID"
      kill -9 "$PID"
    fi
    SLEEP=`expr $SLEEP - 1 `
  done
else
  echo "App not running. Stop aborted."
fi
