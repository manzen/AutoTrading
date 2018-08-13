class SellSettingsController < ApplicationController
  before_action :set_sell_setting, only: [:edit, :update]

  # GET /sell_settings
  # GET /settings.json
  def index
    @sellSetting = SellSetting.first
  end

  # GET /sell_settings/new
  def new
    @sellSetting = SellSetting.new
  end

  # GET /sell_settings/1/edit
  def edit
  end

  # POST /sell_settings
  # POST /sell_settings.json
  def create
    @sellSetting = SellSetting.new(sell_setting_params)

    respond_to do |format|
      if @sellSetting.save
        format.html { redirect_to sell_settings_url, notice: 'SellSetting was successfully created.' }
        format.json { render :show, status: :created, location: @sellSetting }
      else
        format.html { render :new }
        format.json { render json: @sellSetting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sell_settings/1
  # PATCH/PUT /sell_settings/1.json
  def update
    respond_to do |format|
      if @sellSetting.update(sell_setting_params)
        format.html { redirect_to sell_settings_url, notice: 'SellSetting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sellSetting }
      else
        format.html { render :edit }
        format.json { render json: @sellSetting.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_sell_setting
    @sellSetting = SellSetting.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sell_setting_params
    params.require(:sell_setting).permit(:minutes, :increase_percent, :bitcoin, :sell_count)
  end
end
