class Submission < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :student
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => ['application/pdf', 'application/msword', 'text/plain']
  validates :assignment_id, presence: true
  validates :student_id,    presence: true
  validate  :positive_grade

  def graded?
    !grade.nil?
  end

  private

  def positive_grade
    if graded? and grade < 0
        errors.add(:grade, "grade must be nil or >= 0")
    end
  end
end
