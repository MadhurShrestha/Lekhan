class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notebook
  before_action :set_page, only: %i[ show edit update destroy ]
  before_action :set_base_breadcrumbs, only: [:show, :new, :edit]
  skip_before_action :verify_authenticity_token, only: [:update]


    def index
   # @notebooks = Notebook.search(params[:query], filter: ["user_id=#{current_user.id}"])
    @notebooks = current_user.notebooks.pages
    add_breadcrumb("Notebooks")
  end

  # GET /pages/1 or /pages/1.json
  def show
    # @notebooks = current_user.notebooks.all.pagy_search(params[:query])
    @notebooks = current_user.notebooks.all
    add_breadcrumb(@page.title)
    @image_element = @page.image_elements.build
    @checklist = @page.checklists.build
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@page.title}", template: 'pages/pages.html.erb',
        page_size: 'A4',
        orientation: "Landscape",
        lowquality: true,
        zoom: 1,
        dpi: 300,
        margin: { :top => 0, :bottom => 0, :left => 0 , :right => 0}
        # disposition: 'attachment'
      end
    end
  end

  # GET /pages/new
  def new
    add_breadcrumb('New Page')
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
    add_breadcrumb(@page.title, notebook_page_path(@notebook,@page))
    add_breadcrumb('Edit')
  end

  # POST /pages or /pages.json
  def create
    @page = @notebook.pages.build(page_params)
    @page.position = @notebook.get_next_page_position
    if @page.save
      redirect_to notebook_page_path(@notebook,@page), notice: "Page was successfully created."
    else
      render :new
    end
  end



  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to notebook_page_path(@notebook,@page) }
        format.json { render json: @page}
      else
        format.html { render :edit}
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
  end
end
  # DELETE /pages/1 or /pages/1.json
  def destroy
    @page.destroy
    redirect_to @notebook, notice: "Page was successfully destroyed."
  end

  private

  def set_notebook
    @notebook = current_user.notebooks.find(params[:notebook_id])

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = @notebook.pages.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :content)
    end

    def set_base_breadcrumbs
      add_breadcrumb("Notebooks",notebooks_path)
      add_breadcrumb(@notebook.title,notebook_path(@notebook))
    end

end
