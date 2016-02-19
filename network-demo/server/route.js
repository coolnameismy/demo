var fs = require("fs");
var path = require("path");
var formidable = require('formidable');
var uuid = require('node-uuid');
var exclude = require('./exclude');


	//自己写的一个简单的路由
	module.exports = {
		layers:[],
		add:function(url,method,fn){
			var layer = {"url":url,'method':method,'fn':fn}
			layers.push(layer);
		},
		handler:function(req,res){
			
			//排除一些不需要中间件处理的路径
			if(exclude(req.url)){
				// console.log("exclude");
				return;
			}
			console.log(req["headers"]);	
			console.log(req.url);
			switch(req.url){
				case '/' : get(req,res); break;
				case "/download" : download(req,res); break;
				case "/upload" : upload(req,res); break;
				case "/cookie" : cookie(req,res); break;
			}
			
		}
	}

	
	/*
		返回值：{"name":"xxx","age":20}
	*/
	function get(req,res){
		console.log("client cookie:"+req.headers.cookie);
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

	//文件下载
	function download(req,res){
		//写入头
	    // var downloadFilePath = "./1.jpg";
	    var downloadFilePath = "./IMG_0222.jpg";
	    var filename = path.basename(downloadFilePath);
	    var filesize = fs.readFileSync(downloadFilePath).length;
	    res.setHeader('Content-Disposition','attachment;filename=' + filename);//此处是关键
	    res.setHeader('Content-Length',filesize);
	    res.setHeader('Content-Type','application/octet-stream');
	    var fileStream = fs.createReadStream(downloadFilePath,{bufferSize:1024 * 1024});
		 fileStream.pipe(res,{end:true});
		// res.writeHead(200, {'content-type': 'text/html'});
	}

	//文件上传
	function upload(req,res){
		//创建上传表单
		var form = new formidable.IncomingForm();
		//设置编辑
		form.encoding = 'utf-8';
		//设置上传目录
		form.uploadDir = './upload/';
		form.keepExtensions = true;
		//文件大小
		form.maxFieldsSize = 10 * 1024 * 1024;
		form.parse(req, function (err, fields, files) {
			if(err) {
				res.send(err);
				return;
			}
			// console.log(fields);
			console.log("=====");
			// console.log(files);
			// console.log(files.file.name);
			var extName = /\.[^\.]+/.exec(files.file.name);
			var ext = Array.isArray(extName)
				? extName[0]
				: '';
			//重命名，以防文件重复
			var avatarName = uuid() + ext;
			//移动的文件目录
			var newPath = form.uploadDir + avatarName;
			fs.renameSync(files.file.path, newPath);
			// res.send('success');
			var msg = { "status":1,"msg":"succeed"}
			res.write(JSON.stringify(msg));
			res.end();
		});
	}

	//设置cookie
	function cookie(req,res){
		//打印客户端的cookie
		console.log("client cookie:"+req.headers.cookie);
		 
		var today = new Date();
		var time = today.getTime() + 60*1000;
		var time2 = new Date(time);
		var timeObj = time2.toGMTString();
		// res.writeHead({
		//    'Set-Cookie':'myCookie="type=ninja", "language=javascript";path="/";Expires='+timeObj+';httpOnly=true'
		// });
		// res.writeHead(200,{
		// 	'Content-type':'text/json',
		// 	"Set-Cookie":['a=001', 'b=1112', 'c=2222']
		// });

	// res.setHeader("Set-Cookie", "a='001',b='002',c=003");
	    res.setHeader("Set-Cookie", ['d=001;maxAge=10*1000', 'e=1112', 'f=2222;Expires='+timeObj]);

		var msg = { "status":1,"msg":"succeed"}
		res.write(JSON.stringify(msg));
		res.end();
	}


//模拟阻塞
function sleep(milliSeconds) { 
    var startTime = new Date().getTime(); 
    while (new Date().getTime() < startTime + milliSeconds);
 };




