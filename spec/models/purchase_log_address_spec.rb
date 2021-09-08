require 'rails_helper'

RSpec.describe PurchaseLogAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/comment.png')
    @item.save
    @purchase_log = FactoryBot.build(:purchase_log_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it '全ての値が正しく入力されていれば商品購入できる' do
        expect(@purchase_log).to be_valid
      end
      it 'building_nameは空でも商品購入できる' do
        @purchase_log.building_name = ''
        expect(@purchase_log).to be_valid
      end
    end
    context '商品購入できない時' do
      it 'postal_codeが空の場合' do
        @purchase_log.postal_code = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形ではない場合' do
        @purchase_log.postal_code = 3455222
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'prefecture_idが未選択の場合' do
        @purchase_log.prefecture_id = 1
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空の場合' do
        @purchase_log.municipality = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'address_codeが空の場合' do
        @purchase_log.address_code = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Address code can't be blank")
      end
      it 'phone_numberが空の場合' do
        @purchase_log.phone_number = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角数字以外の場合' do
        @purchase_log.phone_number = '１２３４５６７８９１０'
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Phone number is invalid", "Phone number Is not include hyphen(-)")
      end
      it 'tokenが空の場合' do
        @purchase_log.token = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていない場合' do
        @purchase_log.user_id = nil
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていない場合' do
        @purchase_log.item_id = nil
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
