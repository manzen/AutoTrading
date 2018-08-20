class BuySettingsController < ApplicationController
  before_action :set_buy_setting, only: [:edit, :update]

  # GET /buy_settings
  # GET /settings.json
  def index
    @buySetting = BuySetting.first
  end

  # GET /buy_settings/new
  def new
    @buySetting = BuySetting.new
  end

  # GET /buy_settings/1/edit
  def edit
  end

  # POST /buy_settings
  # POST /buy_settings.json
  def create
    @buySetting = BuySetting.new(buy_setting_params)

    respond_to do |format|
      if @buySetting.save
        format.html { redirect_to buy_settings_url, notice: 'BuySetting was successfully created.' }
        format.json { render :show, status: :created, location: @buySetting }
      else
        format.html { render :new }
        format.json { render json: @buySetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buy_settings/1
  # PATCH/PUT /buy_settings/1.json
  def update
    respond_to do |format|
      if @buySetting.update(setting_params)
        format.html { redirect_to buy_settings_url, notice: 'BuySetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @buySetting }
      else
        format.html { render :edit }
        format.json { render json: @buySetting.errors, status: :unprocessable_entity }
      end
    end
  end

  def start
    buySetting = BuySetting.first
    buySetting.is_execution = true
    respond_to do |format|
      if buySetting.save
        format.html { redirect_to buy_settings_url, notice: 'BuySetting was successfully updated.' }
        format.json { render :show, status: :ok, location: buySetting }
      else
        format.html { render :show }
        format.json { render json: buySetting.errors, status: :unprocessable_entity }
      end
    end
  end

  def stop
    buySetting = BuySetting.first
    buySetting.is_execution = false
    respond_to do |format|
      if buySetting.save
        format.html { redirect_to buy_settings_url, notice: 'BuySetting was successfully updated.' }
        format.json { render :show, status: :ok, location: buySetting }
      else
        format.html { render :show }
        format.json { render json: buySetting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_buy_setting
    @buySetting = BuySetting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def buy_setting_params
    params.require(:buy_setting).permit(:minutes, :reduction_percent, :jpy, :buy_count)
  end
end
