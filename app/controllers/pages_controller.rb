class PagesController < ApplicationController
  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render template: 'error_pages/404'
    end
  end

  def create
  end

  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.haml"))
  end
end
