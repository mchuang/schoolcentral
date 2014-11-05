class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student

  validates :assignment_id, presence: true
  validates :student_id,    presence: true
end
