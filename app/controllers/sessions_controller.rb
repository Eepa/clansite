class SessionsController < ApplicationController

  def new

  end


  def create

    user = User.find_by name: params[:name]

    if user.nil?
      redirect_to :back, notice: "User #{params[:name]} does not exist!"

    else

      session[:user_id] = user.id

      redirect_to user,  notice: "Login successful!"

    end



  end

  def destroy

    session[:user_id] = nil

    redirect_to :root

  end

end