Gecko Builder
=============

Input task:
http://docs.taskcluster.net/tools/task-inspector/#lUjbVKk_SRi79QOshjT3Gg

target.linux-x86_64.json:
http://tasks.taskcluster.net/lUjbVKk_SRi79QOshjT3Gg/runs/1/artifacts/target.linux-x86_64.json

target.linux-x86_64.tar.bz2:
http://tasks.taskcluster.net/lUjbVKk_SRi79QOshjT3Gg/runs/1/artifacts/target.linux-x86_64.tar.bz2

target.tests.zip:
http://tasks.taskcluster.net/lUjbVKk_SRi79QOshjT3Gg/runs/1/artifacts/target.tests.zip



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

python scripts/scripts/desktop_unittest.py
--cfg unittests/linux_unittest.py
--mochitest-suite plain1
--download-symbols ondemand
--no-read-buildbot-config
--installer-url http://ftp.mozilla.org/pub/mozilla.org/firefox/tinderbox-builds/mozilla-inbound-linux-debug/1391797503/firefox-30.0a1.en-US.linux-i686.tar.bz2
--test-url http://ftp.mozilla.org/pub/mozilla.org/firefox/tinderbox-builds/mozilla-inbound-linux-debug/1391797503/firefox-30.0a1.en-US.linux-i686.tests.zip


python mozharness/b2g_desktop_unittest.py \
  --cfg b2g/desktop_automation_config.py \
  --test-url
  --installer-url
  --test-suite reftest \
  --download-symbols ondemand
