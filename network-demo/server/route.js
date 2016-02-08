var fs = require("fs");
var path = require("path");

	//自己写的一个简单的路由
	module.exports = {
		layers:[],
		add:function(url,method,fn){
			var layer = {"url":url,'method':method,'fn':fn}
			layers.push(layer);
		},
		handler:function(req,res){
			console.log('handler');
			console.log(req.url);
			switch(req.url){
				case '/' : get(req,res); break;
				case "/download" : download(req,res); break;
			}
			
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
			'age':21
		}
		// sleep(10000);  //等待10秒
		res.write(JSON.stringify(data));

		res.end();
	}

	function download(req,res){
		//写入头
	    var downloadFilePath = "./1.jpg";
	    var filename = path.basename(downloadFilePath);
	    var filesize = fs.readFileSync(downloadFilePath).length;
	    res.setHeader('Content-Disposition','attachment;filename=' + filename);//此处是关键
	    res.setHeader('Content-Length',filesize);
	    res.setHeader('Content-Type','application/octet-stream');
	    var fileStream = fs.createReadStream(downloadFilePath,{bufferSize:1024 * 1024});
		 fileStream.pipe(res,{end:true});
		// res.writeHead(200, {'content-type': 'text/html'});
		// return fileStream;
  //        return file.stream(true).pipe(res);  
  		// res.end('点击此处开始下载');

	}


//模拟阻塞
function sleep(milliSeconds) { 
    var startTime = new Date().getTime(); 
    while (new Date().getTime() < startTime + milliSeconds);
 };
