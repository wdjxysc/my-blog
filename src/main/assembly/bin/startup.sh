#!/bin/sh
#check JAVA_HOME & java
noJavaHome=false
echo $noJavaHome
if [ -z "$JAVA_HOME" ] ; then
    noJavaHome=true
fi
if [ ! -e "$JAVA_HOME/bin/java" ] ; then
    noJavaHome=true
fi

CURR_DIR=`pwd`
cd `dirname "$0"`/..
COMM_HOME=`pwd`
cd $CURR_DIR
if [ -z "$COMM_HOME" ] ; then
    echo
    echo "Error: COMM_HOME environment variable is not defined correctly."
    echo
    exit 1
fi

#startup Server
RUN_CMD="nohup java -Xms128m -Xmx2048m"
RUN_CMD="$RUN_CMD -Dcomm.home=\"$COMM_HOME\""
RUN_CMD="$RUN_CMD -cp \"$COMM_HOME/conf:$COMM_HOME/lib/*\""
RUN_CMD="$RUN_CMD com.my.blog.website.CoreApplication"
RUN_CMD="$RUN_CMD --logging.file=\"$COMM_HOME/logs/stdout.log\" > /dev/null 2>&1 &"
echo $RUN_CMD
eval $RUN_CMD
