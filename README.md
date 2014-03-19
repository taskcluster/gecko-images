Gecko Builder
=============



Artifacts:
 * `/home/worker/object-folder/dist/firefox.linux-x86_64.tar.bz2`
 * `/home/worker/object-folder/dist/firefox.linux-x86_64.json`
 * `/home/worker/object-folder/dist/firefox.tests.zip`


Task payload:
```js
{
  "image":        "registry.taskcluster.net/jonasfj/gecko-builder",
  "command": [
    "./build.sh"
  ],
  "env": {
    "REPOSITORY": "https://hg.mozilla.org/mozilla-central/",
    "REVISION":   "fe40387eba1a",
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

