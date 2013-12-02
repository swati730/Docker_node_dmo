var express = require('express');
var path = require('path');
var app = exports.app = express();
var database = require('./db.js');
app.use(express.bodyParser());
app.set('view engine','ejs');
app.use(express.json());
 var PORT = 3000;

 app.get('/', function (req, res) {
   res.render('index');
   });
app.post('/',function (req,res){

var user=req.body.name,
    pass=req.body.pass;
            database.connect(function(){
             database.createUser(user,pass,null);
   res.end();
            });
            });
   app.listen(PORT)
   console.log('Running on http://localhost:' + PORT);
