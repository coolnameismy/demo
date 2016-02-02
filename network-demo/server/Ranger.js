var Ranger = function(){
	var route = require('./route.js');
	this.create = function(port){
		this.port = port;
	};
	this.listen = function(port){
		var server = require("http").createServer(
			//中间件
			function(req,res){
				//打印request
				// console.log(req);
				// for(var key in req){
				// 	console.log(key);
				// }
				console.log(req["headers"]);
				//交给路由
				route.handler(req,res);
			});
		server.listen(port);
		console.log("app started");
	}
}


module.exports = function(){
	return new Ranger();
};