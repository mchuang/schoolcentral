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

function getCalendarDates(year, month) {
	$.ajax({
  		url: "calendarDates",
  		data: {
  			year: year,
  			month: month
  		},
  		success: function (response) {
            renderCalendarDates(response);
            getCalendarEvents(year, month);
        },
  		dataType: "json"
	});
}

function getCalendarEvents(year, month) {
	$.ajax({
  		url: "calendarEvents",
  		data: {
  			year: year,
  			month: month
  		},
  		success: function (response) {
            renderCalendarEvents(response);
        },
  		dataType: "json"
	});
}

function renderCalendarDates(data) {
	calendarContentNode = document.getElementById("calendar-content");
	calendarHeaderNode = document.getElementById("calendar-header");
	calendarHeaderNode.children[0].innerText = data.monthString;

	while (calendarContentNode.firstChild) {
    	calendarContentNode.removeChild(calendarContentNode.firstChild);
	}

	for (var i = 0; i < data.dates.length; i++) {
		var rowElement = document.createElement("div")
		rowElement.classList.add("row");
		rowElement.classList.add("calendar-week");
		var dates = data.dates[i];
		for (var j = 0; j < dates.length; j++) {
			var dayElement = createDateDiv(dates[j], data.month);
			rowElement.appendChild(dayElement);
		}
		calendarContentNode.appendChild(rowElement);
	}
}

function createDateDiv(dateString, currentMonth) { // ADD ONCLICK FUNCTION
	var dayElement = document.createElement("div");
	dayElement.classList.add("calendar-day")
	dayElement.setAttribute("id", dateString);
	dayElement.setAttribute("onclick", "updateDayFeed(event)");
	var date = new Date(Date.parse(dateString));
	date.setDate(date.getDate() + 1);
	dayElement.innerText = date.getDate();
	if (date.getMonth()+1 != currentMonth) {
		dayElement.style.color = "lightgrey";
	}
	return dayElement;
}

function updateDayFeed(event) {
	var date = new Date(Date.parse(event.currentTarget.id));
	date.setDate(date.getDate() + 1);
	getDayEvents(date.getYear()+1900, date.getMonth()+1, date.getDate());
}

function renderCalendarEvents(data) {
	var date;
	var identifier;
	var eventBlock;
	for (var i = 0; i < data.events.length; i++) {
		calendarEvent = data.events[i];
		date = new Date(Date.parse(calendarEvent.startime));
		identifier = (date.getYear()+1900) + "-" + (date.getMonth()+1) + "-" + date.getDate();
		eventBlock = createEventDiv(calendarEvent);
		document.getElementById(identifier).appendChild(eventBlock);
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
			var eventID = events[i].owner_id;
			$('#day-feed-panel-body').append("<div><a href='../assignments/"+eventID+"'>"+events[i].name+"</a></div>");
		}
	}
}

function formattedDateString(rawDate) {
	//var rawDate = "2014-11-07 18:06:00 UTC"
	var newDate = new Date(Date.parse(rawDate));
	newDate.setDate(newDate.getDate()+1);
	newDate = newDate.toString().split(" ");
	var formattedString = newDate[0] + ", " + newDate[2] + " " + newDate[1] + " " + newDate[3];
	return formattedString;
}

function createEventDiv(calEvent) {
	var calendarElement = document.createElement("div");
	calendarElement.classList.add("event");
	calendarElement.innerText = calEvent.name;
	return calendarElement;
}

function getDayEvents(year, month, day) {
	$.ajax({
  		url: "dayEvents",
  		data: {
  			year: year,
  			month: month,
  			day: day
  		},
  		success: function (response) {
            renderDayEvents(response);
        },
  		dataType: "json"
	});
}
