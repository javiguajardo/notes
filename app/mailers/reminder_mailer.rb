class ReminderMailer < ApplicationMailer
  default from: ENV['GMAIL_USERNAME']

  def reminder_email(user, task)
    @task = task
    @user = user
    mail(to: @user.email, subject: 'Task Reminder')
  end
end
