class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => ["application/pdf"]

  validates :assignment_id, presence: true
  validates :student_id,    presence: true
end
