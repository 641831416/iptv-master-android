#!/bin/bash

#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVEDIFS=$IFS
IFS=$PATH_SEPARATOR
for dir in $PATH ; do
    IFS=$SAVEDIFS
    test -z "$dir" && dir=.
    if test -r "$dir/$PRG"; then
        APP_HOME=$(dirname "$dir/$PRG")
        break
    fi
done
IFS=$SAVEDIFS
if test -z "$APP_HOME"; then
    echo "ERROR: APP_HOME not set."
    exit 1
fi
cd "$APP_HOME" || exit 1

APP_NAME="Gradle"
APP_BASE_NAME=${0##*/}

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "$(uname)" in
  CYGWIN* )
    cygwin=true ;;
  MSYS* )
    msys=true ;;
  Darwin* )
    darwin=true ;;
  NONSTOP* )
    nonstop=true ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar

# Determine the Java version to ensure the wrapper works with Java 17+
JAVA_VERSION=$("$JAVA_HOME/bin/java" -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
if [ "$JAVA_VERSION" = "1" ]; then
    JAVA_VERSION=$("$JAVA_HOME/bin/java" -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f2)
fi
if [ "$JAVA_VERSION" -lt "8" ] || [ "$JAVA_VERSION" -gt "22" ]; then
    die "ERROR: Unsupported Java version: $JAVA_VERSION. Please use Java 8-22."
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin; then
    GRADLE_OPTS="$GRADLE_OPTS \"-Xdock:name=$APP_NAME\" \"-Xdock:icon=$APP_HOME/media/gradle.ico\""
fi

# For Cygwin or MSYS, switch paths to Windows format before running java
if $cygwin || $msys ; then
    APP_HOME=$(cygpath --path --mixed "$APP_HOME")
    CLASSPATH=$(cygpath --path --mixed "$CLASSPATH")
    JAVACMD=$(cygpath --unix "$JAVACMD")

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=$(find / -maxdepth 1 -mindepth 1 -type d 2>/dev/null)
    SEP=" "
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Add a user-defined pattern to the cygpath arguments
    if [ "$GRADLE_CYGPATTERN" != "" ] ; then
        OURCYGPATTERN="($OURCYGPATTERN|($GRADLE_CYGPATTERN))"
    fi
    # Now convert the arguments
    for i in "$@"; do
        CHECKARG=$i
        # Check if argument is a number (posix compliant)
        if [ "$CHECKARG" -eq "$CHECKARG" ] 2>/dev/null; then
            CONTINUE=true
        else
            CONTINUE=false
        fi
        if $CONTINUE; then
            continue
        fi
        if [ $cygwin = true ] || [ $msys = true ]; then
            # Check if argument is not a path (contains no slashes)
            if expr "$i" : '.*/.*' > /dev/null; then
                i=$(cygpath -u "$i")
            fi
        fi
        printf '%s' "$i"
    done
else
    for i in "$@"; do
        printf '%s' "$i"
    done
fi

# Split up the JVM options, to ensure that strings containing spaces are correctly handled
while read -rd ""; do
    JVM_OPTS+=("$REPLY")
done < <(printf '%s\0' $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS | xargs -0 -n1 | grep -v '^-.*version' || true)

# by default we should be in the project directory
cd "$PROJECT_DIR" || exit 1

exec "$JAVACMD" "${JVM_OPTS[@]}" -classpath "$CLASSPATH" org.gradle.wrapper.GradleWrapperMain "$@"
