#@author: voe

class ClassroomsController < ApplicationController
	before_action :require_login

	def show
		@classrooms = current_user.account.classrooms
		@classroom = Classroom.find(params[:id])
	end

	def setAttendance
		logger.debug "---------------- Params: #{params}"
		@classroom = Classroom.find(params[:classroom][:id])
		@date = Date.parse(params[:date])
		logger.debug "-------------- Date: #{@date}"
		if @classroom and @date
			tardys = []
			abscences = []
			attendanceList = params['attendance']
			for student in attendanceList
				logger.debug "-------------- Student: #{student}"
				if student[1] == '1'
					tardys.append(student[0].to_i)
				elsif student[1] == '2'
					abscences.append(student[0].to_i)
				else
					
				end
			end
			Attendance.add_class(@classroom, @date, {tardy: tardys, absent: abscences})
			redirect_to @classroom
		else
			redirect_to @classroom # should add error message
		end
	end

	def setGrades
		@classroom = Classroom.find(params[:classroom][:id])
		@assignment = Assignment.find(params[:assignment])
		if @classroom and @assignment
			gradesSheet = params['grades']
			subs = @assignment.submissions
			subs.each do |sub|
				student = sub.student_id
				studentScore = gradesSheet[student.to_s]
				sub.update(grade: studentScore.to_i)
			end
			redirect_to @classroom
		else
			redirect_to @classroom
		end	
	end
	
	def getClassroom
		@classroom = Classroom.find(params[:id])
		render 'classroominfo'
	end

	def editClassroom
		@classroom = Classroom.find_by_id(params[:id])
		unless @classroom.nil?
			@classroom.update(
				:name => params[:course],
				:time => params[:time],
				:location => params[:location],
				:student_capacity => params[:capacity],
				:teachers => User.where(identifier: params[:teachers].split(',')).map(&:account),
				:students => User.where(identifier: params[:students].split(',')).map(&:account),
			)
		end
		render 'classroominfo'
	end



	def attendanceList
		@classroom = Classroom.find_by_id(params[:id])
		dateString = params[:dateString]
		currentDateTime = DateTime.strptime(dateString, "%Y-%m-%d")
		timeMax = currentDateTime.end_of_day
		attendanceList = Attendance.get_date_range(@classroom, currentDateTime, timeMax)
		#logger.debug "-------------" + attendanceList.to_a.to_s
		studentsDictionary = {}
		@classroom.students.each do |student|
			studentsDictionary[student.id] = [student, student.user]
		end 
		render json: {list: attendanceList, students: studentsDictionary}
	end 


	private

	def require_login
	    unless user_signed_in?
	      flash[:error] = "please log in"
	      redirect_to new_user_session_path
	    end
	end
end
