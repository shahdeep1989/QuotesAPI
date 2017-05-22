class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  # GET /quotes.json
  def index
    if params['length'].to_i & params['length'].to_i != 0
      @quotes = Quote.all.shuffle.first(params['length'].to_i)
    else
      @quotes = Quote.all.shuffle
    end

    #@quotes = Quote.all
    
    respond_to do |format|
      format.html
      format.json { render json: {:data => { :quotes => @quotes}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
    end
  end

  # GET /quotes/1
  # GET /quotes/1.json
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  # POST /quotes.json
  def create
    @quote = Quote.new(quote_params)

    respond_to do |format|
      if @quote.save
        format.html { redirect_to @quote, notice: 'Quote was successfully created.' }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1
  # PATCH/PUT /quotes/1.json
  def update
    respond_to do |format|
      if @quote.update(quote_params)
        format.html { redirect_to @quote, notice: 'Quote was successfully updated.' }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1
  # DELETE /quotes/1.json
  def destroy
    @quote.destroy
    respond_to do |format|
      format.html { redirect_to quotes_url, notice: 'Quote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  # GET /quotes/1/like
  # GET /quotes/1/like.json
  def quote_like
    @quote = set_quote
    @quote.cnt += 1
    respond_to do |format|
      if @quote.save
        #format.html { redirect_to @quote, notice: 'Quote was successfully liked.' }
        #format.json { render :show, status: :created, location: @quote }
        format.json { render json: {:data => { :quotes => @quote}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
      else
        #format.html { render :new }
        #format.json { render json: @quote.errors, status: :unprocessable_entity }
        format.json { render json: { :result => { :errorcode => "", :messages => @quote.errors, :rstatus => 0 }} }
      end
    end
  end

  # GET /quotes/1/like
  # GET /quotes/1/like.json
  def quote_like
    @quote = set_quote
    @quote.cnt += 1
    respond_to do |format|
      if @quote.save
        #format.html { redirect_to @quote, notice: 'Quote was successfully liked.' }
        #format.json { render :show, status: :created, location: @quote }
        format.json { render json: {:data => { :quotes => @quote}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
      else
        #format.html { render :new }
        #format.json { render json: @quote.errors, status: :unprocessable_entity }
        format.json { render json: { :result => { :errorcode => "", :messages => @quote.errors, :rstatus => 0 }} }
      end
    end
  end

  # GET /quotes/1/unlike
  # GET /quotes/1/unlike.json
  def quote_unlike
    @quote = set_quote
    @quote.cnt -= 1
    respond_to do |format|
      if @quote.save
        #format.html { redirect_to @quote, notice: 'Quote was successfully liked.' }
        #format.json { render :show, status: :created, location: @quote }
        format.json { render json: {:data => { :quotes => @quote}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
      else
        #format.html { render :new }
        #format.json { render json: @quote.errors, status: :unprocessable_entity }
        format.json { render json: { :result => { :errorcode => "", :messages => @quote.errors, :rstatus => 0 }} }
      end
    end
  end

  # GET /quotes/import_quote
  def import_quote
    if params[:password] == "12344321"
      @categories = Category.all
    else
      redirect_to root_url, notice: "Contact shahdeep1989@gmail.com for any doubt." 
    end
  end

  def import

    Quote.import(params[:file], params[:category_id])
    redirect_to quotes_import_quote_path, notice: "Quotes imported."
    #redirect_to root_url, notice: "Quotes imported."
  end

  # GET quotes/:id/quotes_by_category.json
  def quotes_by_category
    category_id = params[:id]
    if params[:id] == '-1'
      @quotes_list = Quote.all
    else
      @quotes_list = Quote.all.where(:category_id => category_id)
    end

    if params['length'].to_i & params['length'].to_i != 0
      @quotes_list = @quotes_list.shuffle.first(params['length'].to_i)
    else
      @quotes_list = @quotes_list.shuffle
    end

    

    respond_to do |format|
      if @quotes_list.count > 0
        #format.html { redirect_to @quote, notice: 'Quote was successfully liked.' }
        #format.json { render json: @quotes_list }
        format.json { render json: {:data => { :quotes => @quotes_list}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
      else
        #format.html { render :new }
        #format.json { render json: @quotes_list, status: :unprocessable_entity }
        format.json { render json: { :result => { :errorcode => "", :messages => "No quote is there.", :rstatus => 0 }} }
      end
    end
  end

  # GET quotes/search.json?text=search_keyword
  def search
    @search_keyword = params[:text]

    category_id_list = Category.where("lower(name) like ?","%#{@search_keyword.downcase}%").pluck(:id)
    if category_id_list.count > 0
      @quotes_list = Quote.where(:category_id => category_id_list)
    else
      #@quotes_list = Quote.where("quote like ? OR author like ?","%#{@search_keyword}%","%#{@search_keyword}%")
      @quotes_list = Quote.where("lower(quote) like ? OR lower(author) like ?","%#{@search_keyword.downcase}%","%#{@search_keyword.downcase}%")
    end

    @quotes_list = @quotes_list.shuffle
    
    respond_to do |format|
      if @quotes_list.count > 0
        #format.html { redirect_to @quote, notice: 'Quote was successfully liked.' }
        #format.json { render json: @quotes_list }
        format.json { render json: {:data => { :quotes => @quotes_list}, :result => { :errorcode => "", :messages => "ok", :rstatus => 1 }} }
      else
        #format.html { render :new }
        #format.json { render json: @quotes_list, status: :unprocessable_entity }
        format.json { render json: { :result => { :errorcode => "", :messages => "No quote is there.", :rstatus => 0 }} }
      end
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quote
      @quote = Quote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quote_params
      params.require(:quote).permit(:quote, :author, :cnt)
    end
end
