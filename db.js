var mongoose = require('mongoose');
var db;
var Schema = mongoose.Schema;
var User;
exports.connect = function(callback) {
          var userSchema = new Schema( {
              userName: String,
              password: String
              });
     db = mongoose.createConnection('localhost', 'test');
     db.on('error', function (err) {
      callback(err);
       });
      db.once('open', function (argument) {           
      User =  db.model('User',userSchema);
      callback();
      });
}



exports.createUser = function(u,pHash,callback) {
     var user = new User( { userName:u,password:pHash }  );
             user.save(function(err) {
                        if(callback)
                                              callback(err);
                                                    });

}
exports.getUsers = function(callback) {
      var users =  User.find(function(err,users) {
                callback(users);
                    });
}

exports.close = function(callback) {
          mongoose.connection.close(callback);        
}
