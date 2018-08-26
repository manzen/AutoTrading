class ApplicationController < ActionController::Base
  before_action :basic

  private
  def basic
    name = Settings.auth.name
    passwd = Settings.auth.passwd
    authenticate_or_request_with_http_basic('BA') do |n, p|
      n == name && Digest::SHA1.hexdigest(p) == passwd
    end
  end
end
