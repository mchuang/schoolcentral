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
//= require dropzone


//@author: voe

// Dropzone.autoDiscover = false;

function toggleModal(id) {

	if ($('#'+id).get(0).style.display != 'block') {
		$('#'+id).get(0).style.display = 'block';
	} else {
		$('#'+id).get(0).style.display = 'none';
	}

}

var subTabs = ["students", "assignments", "attendance", "grades"];

function setTab() {
	if (window.location.hash !== "") {
		toggleTab(window.location.hash.substring(1));
	}
}

function toggleTab(identifier) {

	for (var i = 0; i < subTabs.length; i++) {
		var s = subTabs[i];
		var tab = $("#" + s + "-tab").get(0);
		var content = $("#" + s + "-content").get(0);
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
	var newTab = $("#" + newTabId).get(0);
	newTab.classList.add("active");
	newTab.setAttribute("onclick", null);

	var newContentId = identifier + "-content";
	var newContent = $("#" + newContentId).get(0);
	newContent.style.display = "block";

}

function toggleAttendanceModal(dateString, classId) {
	if ($("#attendanceInputModal").get(0).style.display != 'block') {
		$("#attendanceInputModal").get(0).style.display = 'block';
		$("#attendanceTitle").get(0).innerHTML = "attendance for: " + dateString;
		$("#date-specifier").get(0).setAttribute("value", dateString);
		getAttendanceList(dateString, classId);

	} else {
		$("#attendanceInputModal").get(0).style.display = 'none';
	}
}

function getAttendanceList(dateString, classId) {
	$.ajax({
  		url: "attendanceList",
  		data: {
  			dateString: dateString,
  			id: classId

  		},
  		success: function (response) {
  			attendanceList = response['list'];
  			students = response['students'];
            constructAttendanceSheet(attendanceList, students);
        },
  		dataType: "json"
	});
}

function constructAttendanceSheet(attendanceList, students) {
	trIndex = 0
	$('#attendance-table tbody').remove();
	$('#attendance-table').append('<tbody></tbody>');
	if (attendanceList.length > 0) {
		for (var i = 0; i < attendanceList.length; i++) {
			attendanceStatus = attendanceList[i].status;
			studentID = attendanceList[i].student_id;
			studentName = students[studentID][1];
			$('#attendance-table tbody').append('<tr></tr>');
			$('#attendance-table tbody').find('tr').eq(trIndex).append('<td>'+studentName.last_name+ ','+ studentName.first_name+'</td>');
			$('#attendance-table tbody').find('tr').eq(trIndex).append('<td></td>');

			var dropDown = document.createElement("select");
			dropDown.name = 'attendance['+studentID+']';
			dropDown.class = 'attendance-selector';


			var present = document.createElement("option");
			present.text = 'present';
			present.value = 0;
			var tardy = document.createElement("option");
			tardy.text = 'tardy';
			tardy.value = 1;
			var absent = document.createElement("option");
			absent.text = 'absent';
			absent.value = 2;

			dropDown.add(present);
			dropDown.add(tardy);
			dropDown.add(absent);

			if (attendanceStatus == 0) {
				present.selected="selected";
			}else if (attendanceStatus == 1) {
				tardy.selected="selected";
			}else if (attendanceStatus == 2) {
				absent.selected="selected";
			}else {
				alert("Bad attendance code");
			}

			$('#attendance-table tbody').find('tr').eq(trIndex).find('td').eq(1).append(dropDown);

			trIndex += 1
		}

	}else {
		for (var key in students) {
		
			var studentPair = students[key];
			var studentID = studentPair[0].id;
			var studentName = studentPair[1];
			

			$('#attendance-table tbody').append('<tr></tr>');
			$('#attendance-table tbody').find('tr').eq(trIndex).append('<td>'+studentName.last_name+ ','+ studentName.first_name+'</td>');
			$('#attendance-table tbody').find('tr').eq(trIndex).append('<td></td>');

			var dropDown = document.createElement("select");
			dropDown.name = 'attendance['+studentID+']';
			dropDown.class = 'attendance-selector';

			var empty = document.createElement("option");
			empty.text = 'select';
			empty.value = "";
			var present = document.createElement("option");
			present.text = 'present';
			present.value = 0;
			present.selected = "selected";
			var tardy = document.createElement("option");
			tardy.text = 'tardy';
			tardy.value = 1;
			var absent = document.createElement("option");
			absent.text = 'absent';
			absent.value = 2;

			dropDown.add(present);
			dropDown.add(tardy);
			dropDown.add(absent);

			$('#attendance-table tbody').find('tr').eq(trIndex).find('td').eq(1).append(dropDown);
			trIndex += 1
		}

	}
}


function toggleGradesModal(assignmentId, assignmentName, classId) {
	if ($("#gradesInputModal").get(0).style.display != 'block') {
		$("#gradesInputModal").get(0).style.display = 'block';
		$("#gradesTitle").get(0).innerHTML = "Grades for: " + assignmentName;
		$("#assignment-specifier").get(0).setAttribute("value", assignmentId);
		getGradesList(assignmentName, assignmentId, classId)
	} else {
		$("#gradesInputModal").get(0).style.display = 'none';
	}
}


function getGradesList(assignmentName, assignmentID, classID) {
	$.ajax({
  		url: "gradesList",
  		data: {
  			assignmentName: assignmentName,
  			assignmentID: assignmentID,
  			id: classID

  		},
  		success: function (response) {
  			assignments = response['assignment'];
  			students = response['students'];
  			submissions = response['submissions'];
            constructgrades(assignments, submissions, students);
        },
  		dataType: "json"
	});
}

function constructgrades(assignments, submissions, students) {
	trIndex = 0
	$('#grades-table tbody').remove();
	$('#grades-table').append('<tbody></tbody>');
	if (submissions.length > 0) {
		for (var i = 0; i < submissions.length; i++) {
			submission = submissions[i];
			submissionGrade = submission.grade;
			studentID = submission.student_id;
			studentUser = students[studentID][1];


			$('#grades-table tbody').append('<tr></tr>');
			$('#grades-table tbody').find('tr').eq(trIndex).append('<td>'+studentUser.last_name+','+studentUser.first_name+'</td>');
			$('#grades-table tbody').find('tr').eq(trIndex).append('<td></td>');

			var input = document.createElement("input");
			input.name = 'grades['+studentID+']';
			input.class = 'grades-selector';
			input.value = submissionGrade;

			$('#grades-table tbody').find('tr').eq(trIndex).find('td').eq(1).append(input);
			trIndex += 1

		}
	}else {
		//Grades differ from attendence in that the submissions will always be be populated but with nil objects
	}

}





function setCalendarToToday() {
	selectedMonth = new Date();
	dateSelected = false;
	setCalendar(getCalendarYear(), getCalendarMonth(), getCalendarDate());	
	getDayEvents(getCalendarYear(), getCalendarMonth(), getCalendarDate());
}

function setCalendar(year, month, date) {
	$.ajax({
  		url: "calendarDates",
  		data: {
  			year: year,
  			month: month,
  			date: date
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
	calendarContentNode = $("#calendar-content").get(0);
	calendarHeaderNode = $("#month-label");
	calendarHeaderNode.text(data.monthString);

	while (calendarContentNode.firstChild) {
    	calendarContentNode.removeChild(calendarContentNode.firstChild);
	}

	for (var i = 0; i < data.dates.length; i++) {
		var rowElement = document.createElement("div")
		rowElement.classList.add("row");
		rowElement.classList.add("calendar-week");
		var dates = data.dates[i];
		for (var j = 0; j < dates.length; j++) {
			var dayElement = createDateDiv(dates[j], data.year, data.month, data.date);
			rowElement.appendChild(dayElement);
		}
		calendarContentNode.appendChild(rowElement);
	}
}

function createDateDiv(dateString, currentYear, currentMonth, currentDate) {
	var dayElement = document.createElement("div");
	dayElement.classList.add("calendar-day");
	dayElement.setAttribute("id", dateString);
	dayElement.setAttribute("onclick", "updateDayFeed(event)");
	var date = new Date(Date.parse(dateString));
	date.setDate(date.getDate() + 1);
	$(dayElement).text(date.getDate());
	if (date.getMonth()+1 != currentMonth) {
		dayElement.style.color = "lightgrey";
	}
	if (date.getYear()+1900 == currentYear && date.getMonth()+1 == currentMonth && date.getDate() == currentDate) {
		if (!dateSelected) {
			dateSelected = true;
			dayElement.classList.add("active");
		}
	}
	return dayElement;
}

function updateDayFeed(event) {
	var previouslySelected = $(".calendar-day.active");
	for (var i = 0; i < previouslySelected.length; i++) {
		previouslySelected.get(i).classList.remove("active");
	}
	event.currentTarget.classList.add("active");
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
		startDate = calendarEvent.startime;
		endDate = calendarEvent.endtime;
		identifier = startDate.slice(0, 10);
		eventBlock = createEventDiv(calendarEvent);
		$("#" + identifier).get(0).appendChild(eventBlock);
	}
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
		} else {
			$('#day-feed-panel-body').append("<div>" + events[i].name + "</div>");
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
	$(calendarElement).text(calEvent.name);
	return calendarElement;
}

function getCalendarMonth() {
	return selectedMonth.getMonth() + 1;
}

function getCalendarYear() {
	return selectedMonth.getYear() + 1900;
}

function getCalendarDate() {
	return selectedMonth.getDate();
}

function nextMonth() {
	selectedMonth.setMonth(selectedMonth.getMonth() + 1);
	setCalendar(getCalendarYear(), getCalendarMonth(), getCalendarDate());	
}

function previousMonth() {
	selectedMonth.setMonth(selectedMonth.getMonth() - 1);
	setCalendar(getCalendarYear(), getCalendarMonth(), getCalendarDate());
}
