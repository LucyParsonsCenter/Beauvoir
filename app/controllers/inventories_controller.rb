class InventoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction

  # GET /inventories
  # GET /inventories.json
  def index
    @inventories = Inventory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inventories }
    end
  end

  # GET /inventories/1
  # GET /inventories/1.json
  def show
    @inventory = Inventory.find(params[:id])
    @inventory_confirmations = @inventory.inventory_copy_confirmations.includes([:copy => [{:edition => :title }]]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(100)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/new
  # GET /inventories/new.json
  def new
    @inventory = Inventory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inventory }
    end
  end

  # GET /inventories/1/edit
  def edit
    @inventory = Inventory.find(params[:id])
  end

  # POST /inventories
  # POST /inventories.json
  def create
    @inventory = Inventory.new(params[:inventory])

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to @inventory, notice: 'Inventory was successfully created.' }
        format.json { render json: @inventory, status: :created, location: @inventory }
      else
        format.html { render action: "new" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inventories/1
  # PUT /inventories/1.json
  def update
    @inventory = Inventory.find(params[:id])

    respond_to do |format|
      if @inventory.update_attributes(params[:inventory])
        format.html { redirect_to @inventory, notice: 'Inventory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inventories/1
  # DELETE /inventories/1.json
  def destroy
    @inventory = Inventory.find(params[:id])
    @inventory.destroy

    respond_to do |format|
      format.html { redirect_to inventories_url }
      format.json { head :no_content }
    end
  end


  def section
    @section=Category.find(params[:section])
    @inventory = Inventory.find(params[:id])
    copies_on_inventory_already= @inventory.copies.collect {|c| c.id}
    titles=@section.titles
    sorted_titles=titles.sort_by do |title|
      title.authors.first.last_name rescue ""
    end
    
    editions=sorted_titles.collect {|t| t.editions}.flatten

    copies=editions.collect {|e| e.copies.instock}.flatten
    @open_copies=copies.find_all {|c| !(copies_on_inventory_already.include? c.id)}


    respond_to do |format|
      format.html { render :layout => false }
    end
  end


  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    %w[titles.title status].include?(params[:sort]) ? params[:sort] : "created_at"
  end


end