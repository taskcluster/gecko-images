In-Tree Configuration Development
=================================

This folder is used to develop the configuration that should eventually go into
the source tree. `try-taskgraph.js` could also go in the source tree, but it
should probably be rewritten in python, but it's not certain that this would be
useful as pushing to try will eventually do the same.

Try it with:
```sh
cd in-tree;
npm install;
node try-taskgraph.js taskgraph.yml <revision>;
```
Make sure that `<revision>` is a revision available from `hg.mozilla.org/try`.


**Note**, for practical reasons it may not be feasible to put mozconfigs and
other scripts in here just yet. Though, these should be added to the tree.

