// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap.min

function toggleModal(id) {
	if (document.getElementById(id).style.display != 'block') {
		document.getElementById(id).style.display = 'block';
	} else {
		document.getElementById(id).style.display = 'none';
	}
}

var subTabs = ["students", "assigments", "attendance", "grades"];
var selectedTab = "students";

function toggleTab(identifier) {

	var previous = selectedTab;
	
	var oldTabId = previous + "-tab";
	var oldTab = document.getElementById(oldTabId);
	oldTab.classList.remove("active");
	oldTab.addEventListener("click", function(){toggleTab(previous)}, true);

	var oldContentId = previous + "-content";
	var oldContent = document.getElementById(oldContentId);
	oldContent.style.display = "none";

	var newTabId = identifier + "-tab";
	var newTab = document.getElementById(newTabId);
	newTab.classList.add("active");
	newTab.setAttribute("onclick", null);

	var newContentId = identifier + "-content";
	var newContent = document.getElementById(newContentId);
	newContent.style.display = "block";

	selectedTab = identifier;

}