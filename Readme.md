# Drone sonar scanner plugin

Run sonar-scanner on the working directory

## Test

```bash
docker run -it --rm \
    -v `pwd`:`pwd` \
    -w `pwd` \
    -e DRONE_REPO=user/project \
    -e DRONE_COMMIT_BRANCH=develop \
    -e DRONE_BUILD_NUMBER=1 \
    -e DRONE_REPO_SCM=git \
    -e PLUGIN_ADD_BRANCH_PREFIX=true \
    -e PLUGIN_URL=https://some.host.com \
    -e PLUGIN_TOKEN=sometoken \
    rucciva/drone-sonar-plugin:0.0.4
```
