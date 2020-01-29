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

**Optional:** Any java opts (eg `-Xmx512m`)

## Example usage - default, to run `:test` alias

```yaml 
uses: actions/tools.deps-builder@v1
```

## Example usage - invoke `:xyz` alias

```yaml 
uses: actions/tools.deps-builder@v1
with:
  alias: :xyz
```

## Example usage - pass Java opts

```yaml 
uses: actions/tools.deps-builder@v1
with:
  java-opts: -Xmx512m -Xms128m
```

## Example usage - pass Java opts and use `:abc` alias

```yaml 
uses: actions/tools.deps-builder@v1
with:
  alias: :abc
  java-opts: -Xmx512m -Xms128m
```

# License
The scripts and documentation in this project are released under the [MIT License](LICENSE)

