var fs = require('fs');
var data = fs.readFileSync('/home/worker/mozilla-central/b2g/config/gaia.json');
console.log(JSON.parse(data).repo_path);