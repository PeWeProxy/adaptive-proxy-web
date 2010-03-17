class EmailsController < ApplicationController
  def register
    @email = Email.new
  end

  def create
    @email = Email.new({:email => params[:email]})
    @email.save!

    redirect_to '/'
  end
end
