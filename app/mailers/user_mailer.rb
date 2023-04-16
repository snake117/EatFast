class UserMailer < ApplicationMailer
    default from: 'chefonline@gmail.com'
  
    def welcome_email
      @user = params[:user]
      @url  = 'http://example.com/login'
      mail(to: @user.email,
           subject: 'Welcome to My Awesome Site',
           template_path: 'notifications',
           template_name: 'another')
    end
  end
  