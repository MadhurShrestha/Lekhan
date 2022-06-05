class SearchController < ApplicationController
  before_action :authenticate_user!

  def index
    @pages = current_user.pages.search(params[:query])

    add_breadcrumb("Search")
    add_breadcrumb(params[:query]) if params[:query]
  end
end
