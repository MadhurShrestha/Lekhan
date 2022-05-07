class NotebooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notebook, only: %i[ show edit update destroy ]
  before_action :set_base_breadcrumbs, only: [:show, :new, :edit]

  # GET /notebooks or /notebooks.json
  def index
   @notebooks = Notebook.search(params[:query], filter: ["user_id=#{current_user.id}"])
    add_breadcrumb("Notebooks")
  end

  # GET /notebooks/1 or /notebooks/1.json
  def show
    @notebooks = Notebook.all
    add_breadcrumb(@notebook.title)
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     render pdf: "#{@notebooks}", template: 'notebooks/notebooks.html.erb',
    #     page_size: 'A4',
    #     orientation: "Landscape",
    #     lowquality: true,
    #     zoom: 1,
    #     dpi: 300,
    #     margin: { :top => 0, :bottom => 0, :left => 0 , :right => 0}
    #     # disposition: 'attachment'
    #   end
    # end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_notebook
      @notebook =current_user.notebooks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def notebook_params
      params.require(:notebook).permit(:title)
    end

    def set_base_breadcrumbs
      add_breadcrumb("Notebooks",notebooks_path)
    end

end
