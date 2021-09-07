class PurchaseLogsController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @purchase_log_address = PurchaseLogAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_log_address = PurchaseLogAddress.new(purchase_log_params)
    if @purchase_log_address.valid?
      @purchase_log_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_log_params
    params.require(:purchase_log_address).permit(:postal_code, :prefecture_id, :municipality, :address_code, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  # def item_params
  #   params.require(:item).permit(:image, :name, :describe, :category_id, :item_status_id, :delivery_fee_id, :prefecture_id,
  #     :send_by_day_id, :price).merge(user_id: current_user.id)
  # end

end
