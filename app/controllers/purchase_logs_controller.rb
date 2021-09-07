class PurchaseLogsController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    if current_user.id != @item.user_id && @item.purchase_log != nil
      to_root
    elsif current_user.id == @item.user_id
      to_root
    end
    @purchase_log_address = PurchaseLogAddress.new
  end

  def create
    @purchase_log_address = PurchaseLogAddress.new(purchase_log_params)
    if @purchase_log_address.valid?
      pay_item
      @purchase_log_address.save
      to_root
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def to_root
    redirect_to root_path
  end

  def purchase_log_params
    params.require(:purchase_log_address).permit(:postal_code, :prefecture_id, :municipality, :address_code, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_log_params[:token],
      currency: 'jpy'
    )
  end

end
