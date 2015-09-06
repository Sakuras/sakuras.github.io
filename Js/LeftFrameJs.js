var iSelectedLiIndex = 0;	//被选中的li的index

function init()
{
	addEventListener('message', receiver, false);
}

function receiver(e)
{
	if (e.data.indexOf("SubFrameNav") == 0)
	{
		var str = e.data;
		var arr = str.split("|");
		subFrameNav(arr[1], arr[2]);
	}
}

function subFrameNav(path, count) //二级导航函数
{
	//发送滚动条置顶消息
	//原来的URL中包含日文字符，IE竟然不认！！报错！！只好换成“*”了。
	//var index = location.href.indexOf("LeftFrame");
	//var URL = location.href.substring(0, index) + "Main.html";
	parent.postMessage("ScrollToTop", "*");//URL);
	//调整selected。
	var listLis = document.getElementById("listul").getElementsByTagName("li");
	listLis[iSelectedLiIndex].className = "listli";
	listLis[count - 1].className = "listli selected";
	iSelectedLiIndex = count - 1;
	//点击超链接导航
	document.getElementById(path + '_' + count).click();
}
