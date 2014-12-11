# @author: elewis, jdefond

class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy, :autosave => true
	#student is a member of many classrooms
	has_and_belongs_to_many :classrooms

	has_many :events, :as => :owner, :dependent => :destroy

	has_many :attendance
	has_many :submissions
 	
 	#return list of all teachers in all classrooms
 	def teachers
		classrooms.map {|cls| cls.teachers}.flatten.uniq
	end

	alias_method :reminders, :events
	# Return an ActiveRecord::Relation containing all events related to this student
	def events
		# Rewrote SQL in order to allow OR statement, other solutions?
		Event.where('(owner_id = :uid AND owner_type = :typ) OR classroom_id IN (:classes)',
			{ uid: id, typ: "Student", classes: classrooms.map(&:id) })
	end

	# Return total points received by this student for given class, over all submissions
	def recv_points(classroom_id)
		submissions.\
			where(assignment_id: Assignment.where(classroom_id: classroom_id)).\
			where.not(grade: nil).\
			sum(:grade)
	end

	# Return current grade percentage (0.00-1.00) for this student for given class
	def grade(classroom_id)
		max_points = classrooms.find(classroom_id).max_points
		max_points > 0 ? recv_points(classroom_id).to_f / max_points : 0.0
	end

	# Return this student's submission for given assignment
	def submission(assignment_id)
		submissions.find_by_assignment_id(assignment_id)
	end
end
