class LoginController < ApplicationController
  #show login page
  def login
    run User::Operation::Login::Present
  end

  # function actual_login
  def actual_login
    run User::Operation::Login do |result|
      session[:user_id] = result[:user][:id]
      redirect_to root_path
      return
    end
    if result.failure? && result[:email_pw_fail]
      redirect_to login_path
    else
      render :login
    end
  end

  # logout user
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
