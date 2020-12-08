#!/usr/bin/env bash
source $HOME/.bash_profile
source $APP_HOME/../setenv.sh

export JAR="srm-register.jar"
export JAVA_OPTS="-Djava.io.tmpdir=$APP_HOME/tmp -Xms512m -Xmx512m"
export APP_OPTS=""

# 服务端口及管理端口，若默认端口被占用，可自行更改
# export SERVER_PORT="8000"
# export MANAGEMENT_SERVER_PORT="8001"

if [ -r "$APP_HOME/bin/custom.sh" ]; then
  . "$APP_HOME/bin/custom.sh"
fi