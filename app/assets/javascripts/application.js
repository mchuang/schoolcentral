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
//= require moment
//= require jquery.autoSuggest


//@author: voe

function toggleModal(id) {
	if (document.getElementById(id).style.display != 'block') {
		document.getElementById(id).style.display = 'block';
	} else {
		document.getElementById(id).style.display = 'none';
	}
}

var subTabs = ["students", "assignments", "attendance", "grades"];

function toggleTab(identifier) {

	for (var i = 0; i < subTabs.length; i++) {
		var s = subTabs[i];
		var tab = document.getElementById(s + "-tab");
		var content = document.getElementById(s + "-content");
		if (tab && content) {
			tab.classList.remove("active");
			content.style.display = "none";
			switch(s) {
				case "students":
					tab.addEventListener("click", function(){toggleTab("students")}, true);
					break;
				case "assignments":
					tab.addEventListener("click", function(){toggleTab("assignments")}, true);
					break;
				case "attendance":
					tab.addEventListener("click", function(){toggleTab("attendance")}, true);
					break;
				case "grades":
					tab.addEventListener("click", function(){toggleTab("grades")}, true);
					break;
				default:
					break;
			}
		}
	}

	var newTabId = identifier + "-tab";
	var newTab = document.getElementById(newTabId);
	newTab.classList.add("active");
	newTab.setAttribute("onclick", null);

	var newContentId = identifier + "-content";
	var newContent = document.getElementById(newContentId);
	newContent.style.display = "block";

}

function toggleAttendanceModal(dateString) {
	if (document.getElementById("attendanceInputModal").style.display != 'block') {
		document.getElementById("attendanceInputModal").style.display = 'block';
		document.getElementById("attendanceTitle").innerHTML = "attendance for: " + dateString;
		document.getElementById("date-specifier").setAttribute("value", dateString);
	} else {
		document.getElementById("attendanceInputModal").style.display = 'none';
	}
}


function toggleGradesModal(assignmentId, assignmentName) {
	if (document.getElementById("gradesInputModal").style.display != 'block') {
		document.getElementById("gradesInputModal").style.display = 'block';
		document.getElementById("gradesTitle").innerHTML = "Grades for: " + assignmentName;
		document.getElementById("assignment-specifier").setAttribute("value", assignmentId);
	} else {
		document.getElementById("gradesInputModal").style.display = 'none';
	}
}


function renderDayEvents(data) {
	var rawDate = data['date'];
	var panelTitle = formattedDateString(rawDate);
	$('#day-feed-panel-title').html(panelTitle);
	$('#day-feed-panel-body').html('');
	var events = data['events'];
	for(var i = 0; i < events.length; i++) {
		if (events[i].owner_type == "Assignment") {
			$('#day-feed-panel-body').append("<a>events[i].name</a>");
		}
	}
}


function formattedDateString(rawDate) {
	//var rawDate = "2014-11-07 18:06:00 UTC"
	var newDate = new Date(rawDate).toString().split(" ");
	var formattedString = newDate[0] + ", " + newDate[2] + " " + newDate[1] + " " + newDate[3];
	return formattedString;
}



