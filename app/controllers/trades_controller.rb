class TradesController < ApplicationController
  before_action :set_trade, only: %i[ show edit update destroy ]

  # GET /trades or /trades.json
  def index
    @trades = Trade.all
  end

  def goods
    target_category = 'Goods'
    target_expiration = Date.today
    @trades = Trade.where("expiration >= ? AND category = ?", target_expiration, target_category)
  end

  def services
    target_category = 'Services'
    target_expiration = Date.today
    @trades = Trade.where("expiration >= ? AND category = ?", target_expiration, target_category)
  end

  # GET /trades/1 or /trades/1.json
  def show
    @trades = Trade.find(params[:id])
    @categories = Category.all
  end

  # GET /trades/new
  def new
    @trade = Trade.new
    @categories = Category.all
  end

  # GET /trades/1/edit
  def edit
    @trade = Trade.find(params[:id])
    @categories = Category.all
  end

  # POST /trades or /trades.json
  def create
    @trade = Trade.new(trade_params)

    respond_to do |format|
      if @trade.save
        format.html { redirect_to trade_url(@trade), notice: "Trade was successfully created." }
        format.json { render :show, status: :created, location: @trade }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trades/1 or /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to trade_url(@trade), notice: "Trade was successfully updated." }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trades/1 or /trades/1.json
  def destroy
    @trade.destroy

    respond_to do |format|
      format.html { redirect_to trades_url, notice: "Trade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trade_params
      params.require(:trade).permit(:product, :description, :category_name, :category_id, :expiration, :neighborhood, :user_id, :interested_in, :accept, :image_file_name, :image_content_type, :image_updated_at)
    end
end
