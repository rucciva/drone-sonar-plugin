# Drone sonar scanner plugin

Run sonar-scanner on the working directory

## Usage

Secrets:

- sonar_host
- sonar_token

Options:

- sonar_host
- sonar_token
- add_branch_prefix

```yaml
pipeline:
  analyze-code-using-sonarqube:
    image: rucciva/drone-sonar-plugin
    pull: true
    secrets: [sonar_host, sonar_token]
```

or if you want to add branch name as prefix in project name and key

```yaml
pipeline:
  analyze-code-using-sonarqube:
    image: rucciva/drone-sonar-plugin
    pull: true
    secrets: [sonar_host, sonar_token]
    add_branch_prefix: true
```

## Test

```bash
docker run -it --rm \
    -v `pwd`:/usr/local/src/app \
    -w /usr/local/src/app \
    -e DRONE_REPO=user/project \
    -e DRONE_COMMIT_BRANCH=develop \
    -e DRONE_BUILD_NUMBER=1 \
    -e DRONE_REPO_SCM=git \
    -e PLUGIN_ADD_BRANCH_PREFIX=true \
    -e PLUGIN_HOST=https://some.host.com \
    -e PLUGIN_TOKEN=sometoken \
    rucciva/drone-sonar-plugin:0.0.3
```
