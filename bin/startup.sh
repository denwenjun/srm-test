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
#   APP_OPTS   (Optional) Java runtime options used when the "start",
#                    command is executed.
#                   Include here and not in JAVA_OPTS all options, that should
#                   only be used by APP itself, not by the stop process,
#                   the version command etc.
#                   Examples are heap size, GC logging, JMX ports etc.
#
#   JAVA_OPTS       (Optional) Java runtime options used when any command
#                   is executed.
#                   Include here and not in APP_OPTS all options, that
#                   should be used by APP and also by the stop process,
#                   the version command etc.
#                   Most options should go into APP_OPTS.
#
# -----------------------------------------------------------------------------
CLASSPATH=.
SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
APP_HOME=`dirname $DIR`


# create tmp
if [ ! -d "$APP_HOME/tmp" ]; then
  mkdir "$APP_HOME/tmp"
fi

# create logs
if [ ! -d "$APP_HOME/logs" ]; then
  mkdir "$APP_HOME/logs"
fi

if [ -r "$APP_HOME/bin/setenv.sh" ]; then
  . "$APP_HOME/bin/setenv.sh"
fi

if [ -z "$APP_OUT" ] ; then
  APP_OUT="$APP_HOME"/logs/app.out
fi

if jps -ml | grep $JAR ; then
   PID=$(jps -ml | grep $JAR | awk '{print $1}')
   echo "APP appears to still be running with PID $PID. Start aborted."
   echo "If the following process is not a APP APP process, remove the PID file and try again:"
   ps -f -p $PID
   exit 1
fi

eval java $AGENT_OPTS -jar "$JAVA_OPTS" "$APP_OPTS"  $APP_HOME/target/$JAR >> "$APP_OUT" 2>&1 "&"
if jps -ml | grep $JAR ; then
    echo "APP started."
else
    echo "APP start error!"
fi
