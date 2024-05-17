class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private

  def set_log_index
    meal_log_index = current_user.eatings.includes(:meal).to_a
    stool_log_index = current_user.stools.to_a
    @log_index = meal_log_index.concat(stool_log_index)
    if params[:desc]
      @log_index = @log_index.sort_by { |log| log.created_at }.reverse
      session[:sort] = "desc"
      p "params descで判定"
    elsif params[:asc]
      @log_index = @log_index.sort_by { |log| log.created_at }
      session[:sort] = "asc"
      p "params ascで判定"
    else
      if session[:sort] == "desc"
        @log_index = @log_index.sort_by { |log| log.created_at }.reverse
        session[:sort] = "desc"
        p "session descで判定"
      elsif session[:sort] == "asc"
        @log_index = @log_index.sort_by { |log| log.created_at }
        session[:sort] = "asc"
        p "session descで判定"
      end
    end
    p session[:sort]
  end
end
