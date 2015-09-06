var iCountEdu = 0;	//标识履历部分展示到哪一步了
var iCountJp = 0; //标识日语部分展示到哪一步了
var iCountSoft = 0; //标识编程部分展示到哪一步了
var iSelectedEdu = -1; //被选中的Edu栏的选项，-1表示没有
var iSelectedJp = -1;
var iSelectedSoft = -1;

function iCountEduChange(step)
{
	//如果comment还未show，则需要show出来
	if (iCountEdu == 0)
	{
		var oComment = document.getElementById("edu").getElementsByClassName("comment")[0];
		oComment.className += " show1";
	}
	//如果该次点击会触发新rectangle展示，则展示他
	var oRectangle = document.getElementById("edu").getElementsByClassName("rectangle");
	var sClassName = oRectangle[step - 1].className;
	if (sClassName.indexOf("new") > 0)
	{
		oRectangle[step - 1].className = sClassName.replace(" new", "");
		oRectangle[step].className += " show0";
	}
	//设置iCountEdu以符合当前状态
	if (step > iCountEdu)
	{
		iCountEdu = step;
	}
	//如果该次点击会触发新unit展示，则展示他
	if (iCountEdu == 4)
	{
		var oSoftUnit = document.getElementsByClassName("unit")[1];
		sClassName = oSoftUnit.className;
		if (sClassName.indexOf("show1") <= 0)
		{
			oSoftUnit.className = sClassName + " show1";
		}
	}
	if (iCountEdu == 5)
	{
		var oJpUnit = document.getElementsByClassName("unit")[2];
		sClassName = oJpUnit.className;
		if (sClassName.indexOf("show1") <= 0)
		{
			oJpUnit.className = sClassName + " show1";
		}
	}
}

function iCountJpChange(step)
{
	//如果comment还未打开，则需要打开他
	if (iCountJp == 0)
	{
		var oComment = document.getElementById("jp").getElementsByClassName("comment")[0];
		oComment.className += " show1";
	}
	//如果该次点击会触发新rectangle展示，则展示他
	var oRectangle = document.getElementById("jp").getElementsByClassName("rectangle");
	var sClassName = oRectangle[step - 1].className;
	if (sClassName.indexOf("new") > 0)
	{
		oRectangle[step - 1].className = sClassName.replace(" new", "");
		oRectangle[step].className += " show0";
		iCountJp = step;
	}
}

function iCountSoftChange(step)
{
	//如果comment还未打开，则需要打开他
	if (iCountSoft == 0)
	{
		var oComment = document.getElementById("soft").getElementsByClassName("comment")[0];
		oComment.className += " show1";
	}
	//如果该次点击会触发新rectangle展示，则展示他
	var oRectangle = document.getElementById("soft").getElementsByClassName("rectangle");
	var sClassName = oRectangle[step - 1].className;
	if (sClassName.indexOf("new") > 0)
	{
		oRectangle[step - 1].className = sClassName.replace(" new", "");
		oRectangle[step].className += " show0";
		iCountSoft = step;
	}
}

function iSelectedEduChange(iIndex)
{
	//事先记录滚动条值
	var iScrollBarPos = document.body.scrollTop || document.documentElement.scrollTop; //前者用于获取Chrome下的，后者用于IE9
	var oRectangle = document.getElementById("edu").getElementsByClassName("rectangle");
	var oComment = document.getElementById("edu").getElementsByClassName("comment")[0];
	if (iSelectedEdu != -1)
	{
		//如果有正在被选中的选项，需要先把selected标记去掉
		var sClassName = oRectangle[iSelectedEdu].className;
		oRectangle[iSelectedEdu].className = sClassName.replace(" selected", "");
		//隐藏branch之前先把comment的宽度限制放开，方便自适应
		oComment.setAttribute("style", "");
		//如果有正在展示的branch，需要先隐藏掉
		var oBranch = document.getElementById("edu" + iSelectedEdu);
		sClassName = oBranch.className;
		oBranch.className = sClassName.replace(" show0", "");
	}
	//把被选中的选项标记成selected
	oRectangle[iIndex].className += " selected";
	iSelectedEdu = iIndex;
	//隐藏掉branch后把comment的宽度定死
	oComment.setAttribute("style", "width:" + oComment.scrollWidth + "px");
	//展示特定的branch
	document.getElementById("edu" + iIndex).className += " show0";
	//由于高度变化导致滚动条跳动，现在需要变回原来的值
	window.scrollTo(0, iScrollBarPos);
}

function iSelectedJpChange(iIndex)
{
	//事先记录滚动条值
	var iScrollBarPos = document.body.scrollTop || document.documentElement.scrollTop;
	var oRectangle = document.getElementById("jp").getElementsByClassName("rectangle");
	var oComment = document.getElementById("jp").getElementsByClassName("comment")[0];
	if (iSelectedJp != -1)
	{
		//如果有正在被选中的选项，需要先把selected标记去掉
		var sClassName = oRectangle[iSelectedJp].className;
		oRectangle[iSelectedJp].className = sClassName.replace(" selected", "");
		//隐藏branch之前先把comment的宽度限制放开，方便自适应
		oComment.setAttribute("style", "");
		//如果有正在展示的branch，需要先隐藏掉
		var oBranch = document.getElementById("jp" + iSelectedJp);
		sClassName = oBranch.className;
		oBranch.className = sClassName.replace(" show0", "");
	}
	//把被选中的选项标记成selected
	oRectangle[iIndex].className += " selected";
	iSelectedJp = iIndex;
	//隐藏掉branch后把comment的宽度定死
	oComment.setAttribute("style", "width:" + oComment.scrollWidth + "px");
	//展示特定的branch
	document.getElementById("jp" + iIndex).className += " show0";
	//由于高度变化导致滚动条跳动，现在需要变回原来的值
	window.scrollTo(0, iScrollBarPos);
}

function iSelectedSoftChange(iIndex)
{
	//事先记录滚动条值
	var iScrollBarPos = document.body.scrollTop || document.documentElement.scrollTop;
	var oRectangle = document.getElementById("soft").getElementsByClassName("rectangle");
	var oComment = document.getElementById("soft").getElementsByClassName("comment")[0];
	if (iSelectedSoft != -1)
	{
		//如果有正在被选中的选项，需要先把selected标记去掉
		var sClassName = oRectangle[iSelectedSoft].className;
		oRectangle[iSelectedSoft].className = sClassName.replace(" selected", "");
		//隐藏branch之前先把comment的宽度限制放开，方便自适应
		oComment.setAttribute("style", "");
		//如果有正在展示的branch，需要先隐藏掉
		var oBranch = document.getElementById("soft" + iSelectedSoft);
		sClassName = oBranch.className;
		oBranch.className = sClassName.replace(" show0", "");
	}
	//把被选中的选项标记成selected
	oRectangle[iIndex].className += " selected";
	iSelectedSoft = iIndex;
	//隐藏掉branch后把comment的宽度定死
	oComment.setAttribute("style", "width:" + oComment.scrollWidth + "px");
	//展示特定的branch
	document.getElementById("soft" + iIndex).className += " show0";
	//由于高度变化导致滚动条跳动，现在需要变回原来的值
	window.scrollTo(0, iScrollBarPos);
}
