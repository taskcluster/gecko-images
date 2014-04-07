#!/usr/bin/env python

import os, sys
from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter
from urllib   import urlretrieve
from urllib2  import urlopen
from json     import loads

def fetch_artifact_info(taskId):
  # First fetch resolution.json
  print >> sys.stderr, " - downloading resolution.json for " + taskId
  url = "http://tasks.taskcluster.net/" + taskId + "/resolution.json"
  resolution = loads(urlopen(url).read())
  # The we fetch result.json
  print >> sys.stderr, " - downloading result.json for " + taskId
  url = resolution.get('resultUrl')
  result = loads(urlopen(url).read())
  # Now, we return the artifact dictionary
  return result.get('artifacts')

def fetch_artifacts(artifacts, output_folder):
  for name, url in artifacts.iteritems():
    print >> sys.stderr, " - downloading " + name
    target = os.path.join(output_folder, name)
    urlretrieve(url, target)

def main():
  p = ArgumentParser(
    description = 'Fetch artifacts from task',
    formatter_class = ArgumentDefaultsHelpFormatter
  )
  p.add_argument(
    "task_id",
    help = "Identifier for the task to fetch artifacts from"
  )
  p.add_argument(
    "-u", "--url-for",
    help    = "Artifact to get URL for"
  )
  p.add_argument(
    "-o", "--output-folder",
    help    = "Location to put the artifacts",
    default = os.getcwd()
  )
  cfg = p.parse_args()

  print >> sys.stderr, ("Downloading artifacts from " + cfg.task_id + " to " +
                        cfg.output_folder)
  artifacts = fetch_artifact_info(cfg.task_id)
  if cfg.url_for:
    print artifacts.get(cfg.url_for, '')
  else:
    fetch_artifacts(artifacts, cfg.output_folder)

if __name__ == "__main__":
  sys.exit(main())