require 'rails_helper'



RSpec.describe Submission, :type => :model do
 
  
  it {should have_attached_file(:file)}
  it {should validate_attachment_content_type(:file).
                      allowing('application/pdf').rejecting('image/gif')}

 
end
