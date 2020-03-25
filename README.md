# tools.deps-build
A Github action to enable [Clojure](https://clojure.org/index) projects to invoke the [tools.deps CLI](https://clojure.org/guides/deps_and_cli)

The primary goal is to support CI tests.

The action is based on a [Docker container](https://hub.docker.com/repository/docker/vouchio/clj-jdk8-alpine) that has Clojure installed over `adoptopenjdk/openjdk8:alpine-slim`

Note: Since the action is not interactive, it invokes the CLI via `clojure` rather than `clj`. This distinction should usually be unimportant and is mentioned here for completeness.

## Inputs

### `alias`

**Optional:** The alias or concatenated aliases (eg `:ci`, `:mem:test`, ...)

**Default:** `:test`

### `java-opts`

**Optional:** Any java opts, space separated (eg `-Xmx512m`)

**Default:** none are set

### `working-directory`

**Optional:** In case the clojure command should not be executed in the root directory, you can specify another working directory.

### `ssh-key`

**Optional:** A GitHub secret that has the The SSH key needed to access code from other private repositories (eg `${{ secrets.SSH_PRIVATE_KEY }}`)

**Default:** no SSH agent is started or key used

### Why an SSH key?
When running this action to you might need to fetch dependencies from your other private repositories.

GitHub Actions only have access to the repository they run for. To access additional private repositories you need to provide an SSH key with sufficient access privileges.

_Please note that there are some other actions on the GitHub marketplace that enable setting up an SSH agent. Our experience is that the mechanisms to support SSH agent interplay between actions is complex and complexity brings risks. We think that it is more straightforward and secure to have this action support the feature within its own scope. We will continue to review this choice as the Docker options improve and the GitHub environment matures._

**For security purposes, we do not expose the SSH agent outside of this action.**

### SSH Setup
1. Create an SSH key with sufficient access privileges. For security reasons, don't use your personal SSH key but set up a dedicated one for use in GitHub Actions. See the [Github documentation](https://developer.github.com/v3/guides/managing-deploy-keys/) for more support.
1. Make sure you **don't have a passphrase** set on the private key.
1. In your repository, go to the _Settings > Secrets_ menu and create a new secret. In this example, we'll call it `SSH_PRIVATE_KEY`. Put the contents of the private SSH key file into the contents field.
1. This key must start with `-----BEGIN ... PRIVATE KEY-----`, consist of many lines and ends with `-----END ... PRIVATE KEY-----`.

## Example usage - default, to run `:test` alias

```yaml 
uses: actions/tools.deps-builder@v1.0.1
```

## Example usage - pass an SSH key to run the tests

```yaml 
uses: actions/tools.deps-builder@v1.0.1
with:
  ssh-key: ${{ secrets.SSH_PRIVATE_KEY }}
```

## Example usage - invoke `:xyz` alias

```yaml 
uses: actions/tools.deps-builder@v1.0.1
with:
  alias: :xyz
```

## Example usage - pass Java opts

```yaml 
uses: actions/tools.deps-builder@v1.0.1
with:
  java-opts: -Xmx512m -Xms128m
```

## Example usage - pass Java opts and use `:abc` alias

```yaml 
uses: actions/tools.deps-builder@v1.0.1
with:
  alias: :abc
  java-opts: -Xmx512m -Xms128m
```

# License
The scripts and documentation in this project are released under the [MIT License](LICENSE)

