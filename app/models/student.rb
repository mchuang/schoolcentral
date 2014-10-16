class Student < ActiveRecord::Base
	#student has one user object, (as account)
	has_one :user, :as => :account, :dependent => :destroy
	#student is a member of many classrooms 
	has_and_belongs_to_many :classrooms
 	
 	#return list of all teachers in all classrooms
 	def teachers()
		t=[]
		self.classrooms.each do |c|
			t<<c.teachers
		end
		s.flatten!
		s.uniq
	end

end
