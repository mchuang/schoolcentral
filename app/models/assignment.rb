class Assignment < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :classroom
  has_many :submissions

  def get_submission(student_id)
  	submissions.find_by_student_id(student_id)
  end




end
