	//自己写的一个简单的路由
	module.exports = {
		layers:[],
		add:function(url,method,fn){
			var layer = {"url":url,'method':method,'fn':fn}
			layers.push(layer);
		},
		handler:function(req,res){
			console.log('handler');
			get(req,res); 
		}
	}

	
	/*
		返回值：{"name":"xxx","age":20}
	*/
	function get(req,res){
		//写入头
		res.writeHead(200,{
			'Content-type':'text/json'
		});

		var data = {
			'name':'xxx',
			'age':20
		}
		sleep(2000);  //等待10秒
		res.write(JSON.stringify(data));

		res.end();
	}


//模拟阻塞
function sleep(milliSeconds) { 
    var startTime = new Date().getTime(); 
    while (new Date().getTime() < startTime + milliSeconds);
 };
