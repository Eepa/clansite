class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user



  def current_user
    return nil if session[:user_id].nil?

    User.find(session[:user_id])

  end


  def ensure_that_signed_in

    redirect_to signin_path, notice: "You should be signed in"  if current_user.nil?

  end

  def ensure_that_admin_user
    if current_user.nil?
      redirect_to signin_path, notice: "You should be signed in"
    elsif current_user.admin? == false
      redirect_to signin_path, notice:'You should be signed in as admin'
    end
  end

  def modify_entry_successfully(entry, notice_text, format)

      format.html { redirect_to entry, notice: notice_text }
      format.json { head :no_content }

  end

  def modify_entry_fails(entry, render_address, format)
    format.html { render action: render_address }
    format.json { render json: entry.class.errors, status: :unprocessable_entity }
  end

  def destroy_entry(redirect_url, format)
    format.html { redirect_to redirect_url }
    format.json { head :no_content }
  end

end
