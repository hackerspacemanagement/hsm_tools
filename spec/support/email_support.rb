def clear_emails
  sent_emails.clear
end

def sent_emails
  ActionMailer::Base.deliveries
end

def last_email
  sent_emails.last
end

def first_email
  sent_emails.first
end

def urls_in_email(email)
  URI.extract(email.body).uniq
end
