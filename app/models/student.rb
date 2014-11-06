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
		Event.where(classroom_id: classrooms.map(&:id))
	end

	def recv_points(classroom_id)
		submissions.where(assignment_id: Assignment.where(classroom_id: classroom_id)).sum(:grade)
	end

	def grade(classroom_id)
		max_points = classrooms.find(classroom_id).max_points
		max_points > 0 ? recv_points(classroom_id).to_f / max_points : 0.0
	end

	def submission(assignment_id)
		submissions.find_by_assignment_id(assignment_id)
	end
end
