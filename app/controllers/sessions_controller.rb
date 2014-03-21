class SessionsController < ApplicationController

  def new

  end


  def create

    user = User.find_by name: params[:name]

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
      redirect_to user,  notice: "Login successful!"


    else

      redirect_to :back, notice: "Incorrect username or password!"



    end



  end

  def destroy

    session[:user_id] = nil

    redirect_to :root

  end

end