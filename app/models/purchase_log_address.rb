class PurchaseLogAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :address_code, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality
    validates :address_code
    validates :phone_number, format: { with: /\A[0-9]+\z/ }, numericality: {only_integer: true, message: "is invalid. Not include hyphen(-)"}
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"} 

  def save
    purchase_log = PurchaseLog.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address_code: address_code, building_name: building_name, phone_number: phone_number, purchase_log_id: purchase_log.id)
  end
end