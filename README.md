Gecko Images
============

This repository contains scripts needed to build docker images for building and
testing gecko on taskcluster with docker-worker.

An example task could look as follows:
```js
{
  "image":        "registry.taskcluster.net/jonasfj/gecko-builder:latest",
  "command": [
    "./build.sh"
  ],
  "env": {
    "REPOSITORY": "https://hg.mozilla.org/mozilla-central/",
    "REVISION":   "91be2828f17e",
    "MOZCONFIG":  "/home/worker/mozconfigs/b2g-desktop"
  },
  "features": {
    "azureLivelog": true,
    "bufferLog":    false
  },
  "artifacts": {
    "target.linux-x86_64.tar.bz2":
                  "/home/worker/object-folder/dist/target.linux-x86_64.tar.bz2",
    "target.linux-x86_64.json":
                  "/home/worker/object-folder/dist/target.linux-x86_64.json",
    "target.tests.zip":
                  "/home/worker/object-folder/dist/target.tests.zip"
  }
}
```

This sets the environment variables `REPOSITORY`, `REVISION` and `MOZCONFIG`,
it then runs `build.sh` in the image
`registry.taskcluster.net/jonasfj/gecko-builder:latest`.
See `Makefile` for how to build images.

The example task also declares 3 artifacts to be exacted after the task has
finished. The `build.sh` script will make sure artifacts are moved to paths:
 * `/home/worker/object-folder/dist/firefox.linux-x86_64.tar.bz2`
 * `/home/worker/object-folder/dist/firefox.linux-x86_64.json`
 * `/home/worker/object-folder/dist/firefox.tests.zip`


Status
------
The task-graphs and configuration that should eventually live in the tree, is
currently located in the `in-tree/` folder. Along with `try-taskgraph.js` which
should **not** go in the tree, but is present as a utility we can use to test
task-graphs.

Try it with:
```sh
cd in-tree;
npm install;
node try-taskgraph.js task-graph.yml <revision>;
```
Make sure that `<revision>` is a revision available from `hg.mozilla.org/try`.