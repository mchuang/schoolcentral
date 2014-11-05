#@author: voe

class ClassroomsController < ApplicationController

	def show
		@classrooms = current_user.account.classrooms
		@classroom = Classroom.find(params[:id])
	end

	def setAttendance
		@classroom = Classroom.find(params[:classroom][:id])
		@date = Date.parse(params[:date])
		logger.debug "-------------- Date: #{@date}"
		if @classroom and @date
			tardys = []
			abscences = []
			attendanceList = params['attendance']
			for student in attendanceList
				logger.debug "-------------- Student: #{student[1]}"
				if student[1] == '1'
					tardys.append(student[0].to_i)
				elsif student[1] == '2'
					abscences.append(student[0].to_i)
				end
			end
			Attendance.add_class(@classroom, @date, {tardy: tardys, absent: abscences})
			redirect_to @classroom
		else
			redirect_to @classroom # should add error message
		end
	end
	
	def getClassroom
		@classroom = Classroom.find(params[:id])
		render 'classroominfo'
	end

	def editClassroom
		Classroom.editClassroom(params[:course], params[:time], params[:location], params[:description], params[:capacity], params[:teachers].split(','), params[:students].split(','))
		@classroom = Classroom.find_by_id(params[:id])
		render '/dashboard/admin_dashboard'
	end
end
