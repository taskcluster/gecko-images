var request         = require('superagent-promise');
var yaml            = require('yamljs')
var moment          = require('moment');
var _               = require('lodash');
var fs              = require('fs');

// Parameters
var params = {
  reason:       "try-push",
  revision:     process.argv[3],
  repository:   'hg.mozilla.org',
  branch:       'try',
  owner:        process.env.USER + '@localhost.local',
  flags:        "try: Something...",
  created:      moment().toDate().toJSON(),
  deadline:     moment().add('hours', 24).toDate().toJSON()
};

var taskGraph = yaml.parse(fs.readFileSync(process.argv[2]).toString());
taskGraph.params = _.defaults(taskGraph.params, params);

request
  .post('http://scheduler.taskcluster.net/v1/task-graph/create')
  .send(taskGraph)
  .end()
  .then(function(res) {
  if(!res.ok) {
    console.log("Error from scheduler: %j", res.body);
    return;
  }
  console.log("Posted task-graph with id: " + res.body.status.taskGraphId);
  console.log("See: ");
  console.log("http://docs.taskcluster.net/tools/task-graph-inspector/#" +
              res.body.status.taskGraphId);
});

