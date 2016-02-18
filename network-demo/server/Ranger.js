var Ranger = function(){
	var route = require('./route.js');
	this.create = function(port){
		this.port = port;
	};
	this.listen = function(port){
		var server = require("http").createServer(
			//中间件
			function(req,res){
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