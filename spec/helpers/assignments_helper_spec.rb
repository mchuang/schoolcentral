require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the AssignmentsHelper. For example:
#
# describe AssignmentsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

RSpec.describe AssignmentsHelper, :type => :helper do
  # pending "add some examples to (or delete) #{__FILE__}"

  it "should correctly format date" do
    date = DateTime.new(2014, 10, 1, 23, 59, 59)
    formatted = formatDate(date)
    expect(formatted).to eq("October 01, 2014 at 11:59 pm")

    date = DateTime.new(2014, 5, 5, 5, 5, 5)
    formatted = formatDate(date)
    expect(formatted).to eq("May 05, 2014 at  5:05 am")
  end
end
