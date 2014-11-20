require "rails_helper"

RSpec.describe UserMailer, :type => :mailer do

  describe "custom_email" do
    before(:each) do
      UserMailer.custom_email(
        from: "from_addr@fake.com",
        to: "to_addr@fake.com",
        cc: "cc_addr@fake.com",
        bcc: "bcc_addr@fake.com",
        subject: "Test Subject",
        message: "Test Content"
      ).deliver
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it { expect(ActionMailer::Base.deliveries.count).to eq(1) }
    it { expect(ActionMailer::Base.deliveries.last.subject).to eq("Test Subject") }
    it { expect(ActionMailer::Base.deliveries.last.from).to    match_array(["from_addr@fake.com"]) }
    it { expect(ActionMailer::Base.deliveries.last.to).to      match_array(["to_addr@fake.com"]) }
    it { expect(ActionMailer::Base.deliveries.last.cc).to      match_array(["cc_addr@fake.com"]) }
    it { expect(ActionMailer::Base.deliveries.last.bcc).to     match_array(["bcc_addr@fake.com"]) }
  end
end
