## users

| Column                | Type   | Options                   |
|-----------------------|--------|---------------------------|
| nickname              | string | null: false               |
| email                 | string | null: false, unique: true |
| encrypted_password    | string | null: false               |
| name_zenkaku          | string | null: false               |
| name_kana_zenkaku     | string | null: false               |
| birth_day             | date   | null: false               |

### Association
- has_many :items
- has_many :purchase_log

## items

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| item_name       | string     | null: false                    |
| item_describe   | text       | null: false
| category_id     | integer    | null: false                    |
| item_status_id  | integer    | null: false                    |
| delivery_fee_id | integer    | null: false                    |
| send_region_id  | integer    | null: false                    |
| send_by_day_id  | integer    | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one    :purchase_log

## purchase_log

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :address

## address

| Column         | Type    | Options     |
|----------------|---------|-------------|
| postal_code    | integer | null: false |
| prefectures    | string  | null: false |
| municipality   | string  | null: false |
| address_code   | integer | null: false |
| building_name  | string  |             |
| phone_number   | integer | null: false |

### Association
- belongs_to :purchase_log
