# b2g-build image

The b2g-build image is a small wrapper around mozharness b2g_build.py
and a docker image with all the build prerequisites.

An example task could look as follows:
```js
{
  "image":        "registry.taskcluster.net/mozilla/b2g-build:latest",
  "command": [
    "./bin/build"
  ],
  "env": {
    "REPOSITORY": "https://hg.mozilla.org/mozilla-central/",
    "REVISION":   "91be2828f17e",
    "TARGET":  "emulator",
    "B2G_CONFIG": "emulator-ics"
  },
  "features": {
    "azureLivelog": true,
    "bufferLog":    false
  },
  "artifacts": {
    "b2g-crashreporter-symbols.zip": "/home/worker/artifacts/b2g-crashreporter-symbols.zip",
    "b2g-tests.zip": "/home/worker/artifacts/b2g-tests.zip",
    "emulator.tar.gz": "/home/worker/artifacts/emulator.tar.gz",
    "gaia-tests.zip": "/home/worker/artifacts/gaia-tests.zip",
    "sources.xml": "sources.xml"
  }
}
```
