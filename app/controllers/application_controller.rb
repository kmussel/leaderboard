class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from StandardError, :with => :error_render_method
    
  private
  
  def error_render_method(exception)
    if exception.kind_of?(ActionController::BadRequest)      
      render_400
    else
      render_404 
    end
  end
  
  def render_404
    respond_to do |format|
      format.html { render "public/404.html", :status => 404, :layout => false }
      format.all { render :status => 404, :nothing => true }
    end
  end
  
  def render_400
    respond_to do |format|
      format.html { render "public/400.html", :status => 400, :layout => false }
      format.all { render :status => 400, :nothing => true }
    end
  end
  
end
