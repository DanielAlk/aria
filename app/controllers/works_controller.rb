class WorksController < ApplicationController
  include Filterize
  before_action :authenticate_admin!
  before_action :set_work, only: [:show, :edit, :clone, :destroy]
  before_action :set_works, only: [:update_many, :destroy_many]
  before_action :related_objects, only: [:create, :update]
  before_action :filterize, only: :index
  filterize order: :created_at_desc, param: :f, exclude: '`works`.`status` = 3 OR `works`.`status` = 4', exclude_if: Proc.new { |f| ![3, 4].include?(f['scopes']['status'].to_i) rescue true }
  layout 'panel'

  # GET /works
  # GET /works.json
  def index
    @works = @works.paginate(:page => params[:page], :per_page => 7)
    redirect_to new_work_url, notice: 'Completá el formulario para crear una obra' if Work.all.blank?
  end

  # GET /works/1
  # GET /works/1.json
  def show
  end

  # GET /works/new
  def new
    @work = Work.new
  end

  # GET /works/1/edit
  def edit
  end

  # POST /works
  # POST /works.json
  def create
    @work = Work.new(work_params)

    respond_to do |format|
      if @work.save
        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render :show, status: :created, location: @work }
      else
        format.html { render :new }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /works/1/clone
  # POST /works/1/clone.json
  def clone
    work = @work.dup
    @work.images.each do |img|
      work.images.new(item: img.item)
    end
    @work.tags.each do |tag|
      work.taggings.new(tag: tag)
    end
    work.status = :draft

    respond_to do |format|
      if work.save
        format.html { redirect_to edit_work_url work, notice: 'Work was successfully cloned.' }
        format.json { render :show, status: :created, location: work }
      else
        format.html { render :new }
        format.json { render json: work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /works/1
  # PATCH/PUT /works/1.json
  def update
    respond_to do |format|
      if @work.update(work_params)
        format.html { redirect_to @work, notice: 'Work was successfully updated.' }
        format.json { render :show, status: :ok, location: @work }
      else
        format.html { render :edit }
        format.json { render json: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.json
  def destroy
    @work.destroy
    respond_to do |format|
      format.html { redirect_to works_url, notice: 'Work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /works
  # PATCH/PUT /works.json
  def update_many
    respond_to do |format|
      if @works.update_all(work_params)
        format.html { redirect_to works_url, notice: 'Works were successfully updated.' }
        format.json { render :index, status: :ok, location: works_url }
      else
        format.html { render :index }
        format.json { render json: @works.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /works.json
  def destroy_many
    respond_to do |format|
      if (@works.destroy_all rescue false)
        format.html { redirect_to works_url, notice: 'Works were successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to works_url, alert: 'Algunas obras no se puedieron borrar, contactar webmaster.' }
        format.json { render json: @works.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def related_objects
      set_work if params[:id].present?
      @work = @work || Work.new(work_params)
      # Tags
      if params.require(:work)[:update_tags].present?
        if params.require(:work)[:tags].blank?
          @work.taggings.destroy_all
        else
          work_tag_names = @work.tags.map(&:name)
          param_tags = params[:work][:tags].map { |tag_name| tag_name.titlecase }
          @work.tags.each do |tag|
            @work.taggings.where(tag: tag).first.destroy unless param_tags.include? tag.name
          end
          param_tags.each do |tag_name|
            unless work_tag_names.include? tag_name
              if tag = Tag.find_by(name: tag_name)
                @work.taggings.new(tag: tag)
              else
                @work.tags.new(name: tag_name)
              end
            end
          end
        end
      end
      # Tags END
    end
    
    def set_works
      @works = Work.where(id: params[:ids])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_work
      @work = Work.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_params
      params.require(:work).permit(:title, :status, :special, :category_id, :description, :characteristics, :data_sheet, :data_sheet_file, :information, :external_link)
    end
end
