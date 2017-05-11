class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= session[]
  end

end
