#!/usr/bin/env bash

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
APP_HOME=`dirname $DIR`


if [ -r "$APP_HOME/bin/setenv.sh" ]; then
  . "$APP_HOME/bin/setenv.sh"
fi

cd $APP_HOME
mvn clean package -Dmaven.javadoc.skip=true -Dmaven.test.skip=true
mv $APP_HOME/target/app.jar $APP_HOME/target/$JAR