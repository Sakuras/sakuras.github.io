var iLanguageDivIndex = 0;	//标识被选中的语言类型。0为日文，1为中文。
var iStartIndex = 0;	//标识导航栏显示在最左边的li的index。
var iSelectedLiIndex = -1;	//标识被选中的li的index。-1表示没有li被选中。

function init()	//设置消息监听器
{
	addEventListener('message', receiver, false);
}

function receiver(e)
{
	if (e.data == "ScrollToTop")
	{
		scrollTo(0, 0);
		//先把他变小了，新Frame进来才能撑大，不然一开始就过大的话将缩不回去。
		document.getElementById("MainFrame").setAttribute("style", "height:600px");
	}
	else if (e.data.indexOf("SetMainFrameHeight") == 0)
	{
		var str = e.data;
		var arr = str.split("|");
		document.getElementById("MainFrame").setAttribute("style", "height:" + arr[1] + "px");
		setLeftFrameHeight();	//左Frame的bottom齐平
	}
}

function frameNav(iIndex, path)	//导航MainFrame和LeftFrame的函数，修改class以改变相应li的颜色
{
	var oMainFrame = document.getElementById("MainFrame");
	var oLeftFrame = document.getElementById("LeftFrame");
	var oNavLis = document.getElementsByClassName("navul")[0].getElementsByTagName("li");
	if (iSelectedLiIndex != -1)
	{
		var sClassName = oNavLis[iSelectedLiIndex].className;
		oNavLis[iSelectedLiIndex].className = sClassName.replace(" selected", "");
	}
	oNavLis[iIndex].className += " selected";
	iSelectedLiIndex = iIndex;
	//先把他变小了，新Frame进来才能撑大，不然一开始就过大的话将缩不回去，好吧，至少Chrome是这样的。
	oMainFrame.setAttribute("style", "height:600px");
	oMainFrame.src = path + "/" + path + "_1.html";
	oLeftFrame.src = "LeftFrame/" + path + "Left.html";
}

function navliPre()
{
	var oNavLis = document.getElementsByClassName("navul")[0].getElementsByTagName("li");
	if (iStartIndex == 0) return;
	var sClassName = oNavLis[iStartIndex + 3].className;
	oNavLis[iStartIndex + 3].className = sClassName.replace(" show", "");
	oNavLis[iStartIndex - 1].className += " show";
	iStartIndex = iStartIndex - 1;
} 

function navliNext()
{
	var oNavLis = document.getElementsByClassName("navul")[0].getElementsByTagName("li");
	if (iStartIndex == 1) return;
	var sClassName = oNavLis[iStartIndex].className;
	oNavLis[iStartIndex].className = sClassName.replace(" show", "");
	oNavLis[iStartIndex + 4].className += " show";
	iStartIndex = iStartIndex + 1;
} 

function backToIndexPage()
{
	var oMainFrame = document.getElementById("MainFrame");
	oMainFrame.src = "index/index_1.html";
	var oLanDivs = document.getElementsByClassName("language")[0].getElementsByTagName("div");
	oLanDivs[iLanguageDivIndex].click();
	//如果之前有选中的li的话，把他的selected去掉。
	if (iSelectedLiIndex != -1)
	{
		var oNavLis = document.getElementsByClassName("navul")[0].getElementsByTagName("li");
		var sClassName = oNavLis[iSelectedLiIndex].className;
		oNavLis[iSelectedLiIndex].className = sClassName.replace(" selected", "");
		iSelectedLiIndex = -1;
	}
}

function setLeftFrameHeight()	//保持左Frame的bottom齐平
{
	var iMainFrameHeight = document.getElementById("MainFrame").offsetHeight;
	var iLogoHeight = document.getElementById("logo").offsetHeight;
	var iLeftFrameHeight = iMainFrameHeight - iLogoHeight + 16;
	document.getElementById("LeftFrame").setAttribute("style", "height:" + iLeftFrameHeight + "px");
}

function resetUpToTopPos()	//动态改变“滚回顶上”的超链接位置
{
	var oUpToTop = document.getElementsByClassName("upToTop")[0];
	var iScrollTop = document.body.scrollTop;
	var sDisplay = "none";
	if (iScrollTop > 10)
	{
		sDisplay = "block";
	}
	var iTop = iScrollTop + document.documentElement.clientHeight - 80;
	oUpToTop.setAttribute("style", "display:" + sDisplay + ";top:" + iTop + "px");
}

function changeLanguage(iIndex, lan)
{
	var oLanDivs = document.getElementsByClassName("language")[0].getElementsByTagName("div");
	var sClassName = oLanDivs[iLanguageDivIndex].className;
	oLanDivs[iLanguageDivIndex].className = sClassName.replace(" selected", "");
	oLanDivs[iIndex].className += " selected";
	iLanguageDivIndex = iIndex;
	document.getElementById("LeftFrame").src = "LeftFrame/indexLeft_" + lan + '.html'; 
}

function setLanguagePos()
{
	document.getElementsByClassName("lanArea")[0].setAttribute("style", "top:" + (event.clientY - 20) + "px;left:" + (event.clientX - 20) + "px");
}

function showLanguage()
{
	document.getElementsByClassName("lanArea")[0].style.display = "block";
}

function hideLanguage()
{
	document.getElementsByClassName("lanArea")[0].style.display = "none";
}

function showNavliPre()
{
	if (iStartIndex == 0)
	{
		return;
	} 
	var NavliPreDiv = document.getElementsByClassName("preDiv")[0];
	NavliPreDiv.setAttribute("style", "width:8%;background-image:url('images/LeftArray.png')");
	var Navul =document.getElementsByClassName("navul")[0];
	Navul.setAttribute("style", "width:90%");
}

function hideNavliPre()
{
	var NavliPreDiv = document.getElementsByClassName("preDiv")[0];
	NavliPreDiv.setAttribute("style", "width:2%");
	var Navul =document.getElementsByClassName("navul")[0];
	Navul.setAttribute("style", "width:96%");
}

function showNavliNext()
{
	if (iStartIndex == 1)
	{
		return;
	} 
	var NavliNextDiv = document.getElementsByClassName("nextDiv")[0];
	NavliNextDiv.setAttribute("style", "width:8%;background-image:url('images/RightArray.png')");
	var Navul =document.getElementsByClassName("navul")[0];
	Navul.setAttribute("style", "width:90%");
}

function hideNavliNext()
{
	var NavliNextDiv = document.getElementsByClassName("nextDiv")[0];
	NavliNextDiv.setAttribute("style", "width:2%");
	var Navul =document.getElementsByClassName("navul")[0];
	Navul.setAttribute("style", "width:96%");
}
