class Contact < MailForm::Base
    attribute :first_names,      :validate => true
    attribute :last_names,       :validate => true
    attribute :emails,    :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    attribute :comments
    attribute :phone_numbers,    :validate => /\\+*.\\s+\\([0-9]+*.-*.\\)/
  
    # Declare the e-mail headers. It accepts anything the mail method
    # in ActionMailer accepts.
    def headers
      {
        :subject => "Contact Form Inquiry",
        :to => "mckenziebrower220@gmail.com",
        :from => %("#{first_names}" + "#{last_names}" <#{email}>)
      }
    end
end