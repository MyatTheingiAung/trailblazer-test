require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe 'example' do
    let(:mail) { described_class.example(User.first).deliver_now }
    def current_user
      @current_user ||= User.find(1)
    end

    it 'renders the subject' do
      expect(mail.subject).to eq('Test Email for Letter Opener')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([User.first.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end
  end
end
