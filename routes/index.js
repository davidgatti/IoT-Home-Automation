var express = require('express');
var request = require('request');
var secrets = require('./secrets.js');

var router = express.Router();

router.post('/', function(req, res, next) {
  // res.render('index', { title: 'Express2' });

  console.log(req.body);

  delete req.body['event'];
  delete req.body['data'];
  delete req.body['published_at'];
  delete req.body['coreid'];

  res.send(req.body);

  var options = {
    url: 'https://api.parse.com/1/classes/History_Water', //URL to hit
    qs: {from: 'blog example', time: +new Date()}, //Query string data
    method: 'POST', //Specify the method
    headers: { //We can define headers too
      "X-Parse-Application-Id": secrets.applicatioID,
      "X-Parse-REST-API-Key": secrets.apiKey
    },
    body: JSON.stringify(req.body)
  };

  request(options, function (error, response, body) {
    if (!error && response.statusCode == 200) {
      console.log(body); // Show the HTML for the Modulus homepage.
    }
  });


});

module.exports = router;
