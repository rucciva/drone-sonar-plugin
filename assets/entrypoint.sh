#!/bin/bash

set -euo pipefail

PLUGIN_ADD_BRANCH_PREFIX=${PLUGIN_ADD_BRANCH_PREFIX:-false}

PROJECT_NAME=$DRONE_REPO
if [ 'true' == "$(echo $PLUGIN_ADD_BRANCH_PREFIX | tr '[:upper:]' '[:lower:]')" ]; then 
    PROJECT_NAME="$DRONE_REPO/$DRONE_COMMIT_BRANCH"
fi

MY_EXECUTABLE=sonar-scanner
ARGS=()
ARGS+=("-Dsonar.projectName="$PROJECT_NAME)
ARGS+=("-Dsonar.projectKey="${PROJECT_NAME//\//:})
ARGS+=("-Dsonar.host.url="${SONAR_HOST:-$PLUGIN_SONAR_HOST})
ARGS+=("-Dsonar.login="${SONAR_TOKEN:-$PLUGIN_SONAR_TOKEN})
ARGS+=("-Dsonar.projectVersion="${DRONE_BUILD_NUMBER:-"0"})
ARGS+=("-Dsonar.scm.provider="${DRONE_REPO_SCM:-"git"})

if [ "$#" -eq 0 ]; then
	set -- "$MY_EXECUTABLE" "${ARGS[@]}"
elif [ "${1:0:1}" = '-' ]; then
    set -- "$MY_EXECUTABLE" "${ARGS[@]}" "$@"
fi

export SONAR_USER_HOME=${SONAR_USER_HOME:-.sonar}
exec "$@"