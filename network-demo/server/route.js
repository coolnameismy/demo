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
		返回值：{"name":"liuyanwei","age":30}
	*/
	function get(req,res){
		//写入头
		res.writeHead(200,{
			'Content-type':'text/json'
		});

		// res.write('name2');
		var data = {
			'name':'liuyanwei',
			'age':30
		}
		res.write(JSON.stringify(data));

		res.end();
	}