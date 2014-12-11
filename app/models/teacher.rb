# @author: elewis, jdefond

class Teacher < ActiveRecord::Base
	# teacher has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy, :autosave => true
	#teacher is a member of many classrooms 
	has_and_belongs_to_many :classrooms

	has_many :events, :as => :owner, :dependent => :destroy

    has_many :assignments

	#return list of all students for a teacher in all classrooms
	def students
		classrooms.map {|cls| cls.students}.flatten.uniq
	end

	alias_method :reminders, :events
	# Return an ActiveRecord::Relation containing all events related to this teacher
	def events
		# Rewrote SQL in order to allow OR statement, other solutions?
		Event.where('(owner_id = :uid AND owner_type = :typ) OR classroom_id IN (:classes)',
			{ uid: id, typ: "Teacher", classes: classrooms.map(&:id) })
	end
end
