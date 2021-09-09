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
        expect(@purchase_log.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形ではない場合' do
        @purchase_log.postal_code = 3455222
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("郵便番号はハイフンを含めた半角7桁（例：123-4567）で記述してください")
      end
      it 'prefecture_idが未選択の場合' do
        @purchase_log.prefecture_id = 1
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("都道府県が未選択です")
      end
      it 'municipalityが空の場合' do
        @purchase_log.municipality = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'address_codeが空の場合' do
        @purchase_log.address_code = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空の場合' do
        @purchase_log.phone_number = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが9桁以下では購入できない' do
        @purchase_log.phone_number = '09000000'
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberが12桁以上では購入できない' do
        @purchase_log.phone_number = '090000000000'
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberに半角数字以外が含まれている場合は購入できない' do
        @purchase_log.phone_number = '１２３４５６７８９１０'
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("電話番号は不正な値です")
      end
      it 'phone_numberにハイフン(-)が含まれている場合は購入できない' do
        @purchase_log.phone_number = '090-1234-5678'
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("電話番号はハイフン無しの半角数字10桁、もしくは11桁で記述してください")
      end
      it 'tokenが空の場合' do
        @purchase_log.token = ''
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it 'userが紐付いていない場合' do
        @purchase_log.user_id = nil
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Userを入力してください")
      end
      it 'itemが紐付いていない場合' do
        @purchase_log.item_id = nil
        @purchase_log.valid?
        expect(@purchase_log.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
