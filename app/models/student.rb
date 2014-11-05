# @author: elewis, jdefond

class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
	#student is a member of many classrooms
	has_and_belongs_to_many :classrooms

	has_many :attendance
	has_many :submissions
 	
 	#return list of all teachers in all classrooms
 	def teachers
		classrooms.map {|cls| cls.teachers}.flatten.uniq
	end

	def events 
		classrooms.map {|cls| cls.events}.flatten
	end

	def grade(classroom_id)
		recv_points = submissions.where(assignment_id: Assignment.where(classroom_id: classroom_id)).sum(:grade)
		recv_points.to_f / classrooms.find(classroom_id).max_points
	end

	def submission(assignment_id)
		submissions.find_by_assignment_id(assignment_id)
	end
end
