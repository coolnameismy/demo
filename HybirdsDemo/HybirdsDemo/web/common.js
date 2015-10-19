$(function(){
	showInfo("开始渲染btns")
	btnsInit()
})


var showInfo = function(msg){
	$(".info").html(msg);
}

var hello = function(){
	alert("hello")
}

var hello = function(msg){
	alert("hello " + msg)
	if(msg.obj != undefined)
		alert(msg.obj)
}


var btnsInit = function(){
	var btns = ["js-btn:调用自身js的hello方法","js-btn:调用ios的hello方法","js-btn:调用ios的hello(msg)方法"]
	$.each(btns,function(i,item){
		var btnHtml = "<a>" + item+"</a>"
		$(".btns").append(btnHtml)
	})
	$(".btns a").click(function(){
		var btnText = $(this).html()
		showInfo("你点击了："+btnText)
		if (btnText ==btns[0]) {
			hello()
		}
		if (btnText ==btns[1]) {
			document.location = "hello://";
		}
		if (btnText ==btns[2]) {
			document.location = "hello://hello_liuyanwei";
		}
	})	

	showInfo("html加载完成")
}