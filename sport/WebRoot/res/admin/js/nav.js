
/****************************代码****************************/

function list_sub_detail(Id, item) {
	if (preClassName != "") {
		$("\#"+preClassName).attr('class',"left_back");
	}
	if ($("\#"+Id).attr('class') == "left_back") {
		$('\#'+Id).attr('class',"left_back_onclick");
		outlookbar.getbyitem(item);
		preClassName = Id
	}
}

function outlook() {
	this.titlelist = new Array();
	this.itemlist = new Array();
	this.addtitle = addtitle;
	this.additem = additem;
	this.getbytitle = getbytitle;
	this.getbyitem = getbyitem;
	this.getdefaultnav = getdefaultnav;
}
function theitem(intitle, insort, inkey, inisdefault) {
	this.sortname = insort;
	this.key = inkey;
	this.title = intitle;
	this.isdefault = inisdefault
}
function addtitle(intitle, sortname, inisdefault) {
	outlookbar.itemlist[outlookbar.titlelist.length] = new Array();
	outlookbar.titlelist[outlookbar.titlelist.length] = new theitem(intitle, sortname, 0, inisdefault);
	return (outlookbar.titlelist.length - 1)
}
function additem(intitle, parentid, inkey) {
	if (parentid >= 0 && parentid <= outlookbar.titlelist.length) {
		insort = "item_" + parentid;
		outlookbar.itemlist[parentid][outlookbar.itemlist[parentid].length] = new theitem(intitle, insort, inkey, 0);
		return (outlookbar.itemlist[parentid].length - 1)
	} else
		additem =  - 1
}
function getdefaultnav(sortname) {
	var output = "";
	for (i = 0; i < outlookbar.titlelist.length; i++) {
		if (outlookbar.titlelist[i].isdefault == 1 && outlookbar.titlelist[i].sortname == sortname) {
			
			output += "<div  class='list_tilte_onclick' id=sub_sort_" + i + " onclick=\"hideorshow('sub_detail_" + i + "')\">";
			output += "<span>" + outlookbar.titlelist[i].title + "</span>";
			output += "</div>";
			output += "<div style='display:none;' class=list_detail id=sub_detail_" + i + " ><ul>";
			for (j = 0; j < outlookbar.itemlist[i].length; j++) {
				output += "<li id=" + outlookbar.itemlist[i][j].sortname + j + " onclick=\"changeframe('" + outlookbar.itemlist[i][j].title + "', '" + outlookbar.titlelist[i].title + "', '" + outlookbar.itemlist[i][j].key + "')\"><a href='"+outlookbar.itemlist[i][j].key+"' target='manFrame'>" + outlookbar.itemlist[i][j].title + "</a></li>"
			}
			output += "</ul></div>"
			
		}
	}
	$('#right_main_nav').html(output);
}
function getbytitle(sortname) {
	var output = "<ul>";
	for (i = 0; i < outlookbar.titlelist.length; i++) {
		if (outlookbar.titlelist[i].sortname == sortname) {
			output += "<li id=left_nav_" + i + " onclick=\"list_sub_detail(id, '" + outlookbar.titlelist[i].title + "')\" class=left_back>" + outlookbar.titlelist[i].title + "</li>"
		}
	}
	output += "</ul>";
	$('#left_main_nav').html(output);
}
function getbyitem(item) {
	var output = "";
	for (i = 0; i < outlookbar.titlelist.length; i++) {
		if (outlookbar.titlelist[i].title == item) {
			output = "<div class=list_tilte id=sub_sort_" + i + " onclick=\"hideorshow('sub_detail_" + i + "')\">";
			output += "<span>" + outlookbar.titlelist[i].title + "</span>";
			output += "</div>";
			output += "<div class=list_detail id=sub_detail_" + i + " style='display:block;'><ul>";
			for (j = 0; j < outlookbar.itemlist[i].length; j++) {
				output += "<li id=" + outlookbar.itemlist[i][j].sortname + "_" + j + " onclick=\"changeframe('" + outlookbar.itemlist[i][j].title + "', '" + outlookbar.titlelist[i].title + "', '" + outlookbar.itemlist[i][j].key + "')\"><a href='"+outlookbar.itemlist[i][j].key+"' target='manFrame'>" + outlookbar.itemlist[i][j].title + "</a></li>"
			}
			output += "</ul></div>"
		}
	}
	$('#right_main_nav').html( output);
}
function changeframe(item, sortname, src) {
	if (item != "" && sortname != "") {
		$('#show_text',$("frame[name='mainFrame']",parent.document)).html(sortname + "  <img src=../src/admin/images/slide.gif broder=0 />  " + item);
	}
	if (src != "") {
		window.top.frames['manFrame'].location = src;
	}
}
function hideorshow(divid) {
	subsortid = "sub_sort_" + divid.substring(11);
	if ($('\#'+divid).css('display') == "none") {
		$('\#'+divid).css('display',"block");
		$('\#'+subsortid).attr('class',"list_tilte");
	} else {
		$('\#'+divid).css('display',"none");
		$('\#'+subsortid).attr('class',"list_tilte_onclick");
	}
}


