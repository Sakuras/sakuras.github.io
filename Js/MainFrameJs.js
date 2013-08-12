function init()
{
	//给示例代码动态添加行号，计算高度
	var pre = document.getElementsByTagName("pre");
	var code = document.getElementsByTagName("textarea");
	var lineNumDiv = document.getElementsByClassName("lineNum");
	var iLength = pre.length;
	var iCodeHeight;
	for (var i = 0; i < iLength; i++)
	{ 
		var RowsCount = getRowsCount(code[i]);
		fillLineNum(pre[i], RowsCount);	//填写行号
		iCodeHeight = 10 + 15 * RowsCount;	//计算高度
		if (iCodeHeight > 460)
		{
			iCodeHeight = 460;
		}
		lineNumDiv[i].setAttribute("style", "height:" + iCodeHeight + "px"); 
		code[i].setAttribute("style", "height:" + iCodeHeight + "px"); 
	}
	//给外层发消息告知自己的高度
	//原来的URL中包含日文字符，IE竟然不认！！报错！！只好换成“*”了。
	//var type = document.title.substring(0, document.title.indexOf("_"));
	//var index = location.href.indexOf(type);
	//var URL = location.href.substring(0, index) + "Main.html";
	var iHeight = document.body.scrollHeight + 100;	//加100留点余裕
	parent.postMessage("SetMainFrameHeight|" + iHeight, "*");//URL);
}

function subFrameNav(path, count)	//二级导航函数
{
	//发送导航消息给LeftFrame，由它的同名函数处理
	//原来的URL中包含日文字符，IE竟然不认！！报错！！只好换成“*”了。
	//var index = location.href.indexOf(path);
	//var URL = location.href.substring(0, index) + "LeftFrame/" + path + "Left.html";
	parent.frames[0].postMessage("SubFrameNav|" + path + "|" + count, "*");//URL);
}

function getRowsCount(objTextArea)	//获取textarea的行数
{
	var str = escape(objTextArea.innerHTML);
	var arr = str.split("%0A");
	return arr.length;
}

function fillLineNum(objPre, RowCount)	//填写行号
{
	for (var i = 1; i <= RowCount; i++)
	{
		objPre.innerHTML = objPre.innerHTML + i + "<br/>";
	}
}

function lineNumDivScrollTo(oTextarea)	//同步相应Div的滚动条
{
	var oLineNumDiv = oTextarea.parentNode.childNodes[1];
	oLineNumDiv.scrollTop = oTextarea.scrollTop;
}

function easterEgg0MouseOver(oEasterEgg0)
{
	oEasterEgg0.innerText = "Sakuras是世界上最好的人。";
	oEasterEgg0.nextSibling.nextSibling.innerText = "我也是来吐槽楼上的。";
}

function easterEgg0MouseOut(oEasterEgg0)
{
	oEasterEgg0.innerText = "没了。";
	oEasterEgg0.nextSibling.nextSibling.innerText = "我是来吐槽楼上的。";
}
