class CategoriesController < ApplicationController
  before_filter :hack_out_params, :only=>[:create,:update]
  before_filter :authenticate_user!, :except=>[:show,:index] 
  
  load_and_authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.order("name asc")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end


  private
  def hack_out_params
    unless params[:category][:category_title_list_memberships_attributes].nil?
      params[:category][:category_title_list_memberships_attributes].each do |k,v| 
        params[:category][:category_title_list_memberships_attributes][k].delete :title_list
      end
    end
  end


  def category_params
    params.require( :description, :image, :name,:remote_image_url, :category_title_list_memberships_attributes)
    params.permit( :description, :image, :name,:remote_image_url, :category_title_list_memberships_attributes)
  end
end
