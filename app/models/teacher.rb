class Teacher < ActiveRecord::Base
	# teacher has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
	#teacher is a member of many classrooms 
	has_and_belongs_to_many :classrooms

	#return list of all students for a teacher in all classrooms
	def students()
		s=[]
		self.classrooms.each do |c|
			print( c.students )
			s<<c.students
		end
		s.flatten!
		s.uniq
	end
end
