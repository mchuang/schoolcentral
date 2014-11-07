# @author: elewis, jdefond

class Teacher < ActiveRecord::Base
	# teacher has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
	#teacher is a member of many classrooms 
	has_and_belongs_to_many :classrooms

    has_many :assignments

	#return list of all students for a teacher in all classrooms
	def students
		classrooms.map {|cls| cls.students}.flatten.uniq
	end

	def events 
		Event.where(classroom_id: classrooms.map(&:id))
	end
end
