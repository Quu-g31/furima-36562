class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :send_by_day

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :describe
    validates :price, numericality: true, format: { with: /\A[0-9]+\z/ }
  end
  with_options numericality: { other_than: 1, message: "can't be blank"} do
    validates :category_id
    validates :item_status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :send_by_day_id
  end
end
