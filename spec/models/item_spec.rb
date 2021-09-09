require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/comment.png')
  end

  describe '商品出品' do
    context '商品出品ができる場合' do
      it 'image、name、describe、price、category_id、item_status、delivery_fee_id、prefecture_id、send_by_idが存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it 'priceは半角数字のみの入力で出品できる' do
        @item.price = '11111'
        expect(@item).to be_valid
      end
      it 'priceは300以上、10000000未満で出品できる' do
        @item.price = '11111'
        expect(@item).to be_valid
      end
    end
    context '商品出品できない場合' do
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'describeが空では出品できない' do
        @item.describe = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品説明を入力してください")
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("値段を入力してください")
      end
      it 'priceが半角数字以外では出品できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は数値で入力してください')
      end
      it 'priceが300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は299より大きい値にしてください')
      end
      it 'priceが10000000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('値段は10000000より小さい値にしてください')
      end
      it 'category_idが未選択では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーが未選択です")
      end
      it 'item_status_idが未選択では出品できない' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態が未選択です")
      end
      it 'delivery_fee_idが未選択では出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担が未選択です")
      end
      it 'prefecture_idが未選択では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の都道府県が未選択です")
      end
      it 'item_status_idが未選択では出品できない' do
        @item.send_by_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数が未選択です")
      end
      it 'ユーザーが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
