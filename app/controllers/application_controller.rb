class ApplicationController < ActionController::Base
  before_action :basic

  private
  def basic
    name = 'admin'
    passwd = 'cdf547ed4c64e6994af35cfcd69c4204c9227a97'
    authenticate_or_request_with_http_basic('BA') do |n, p|
      n == name && Digest::SHA1.hexdigest(p) == passwd
    end
  end
end
