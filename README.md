## users

| Column             | Type   | Options     |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| e-mail             | string | null: false |
| encrypted_password | string | null: false |

### Association
- has_many :items
- has_many :purchase_log

## items

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| item_name    | string     | null: false                    |
| category     | string     | null: false                    |
| item_status  | string     | null: false                    |
| delivery_fee | string     | null: false                    |
| send_region  | string     | null: false                    |
| send_by_day  | integer    | null: false                    |
| price        | integer    | null: false                    |
| user_id      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one    :purchase_log

## purchase_log

| Column           | Type       | Options                        |
|------------------|------------|--------------------------------|
| credit_cade_code | integer    | null: false                    |
| user_id          | references | null: false, foreign_key: true |
| item_id          | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :items
- has_one    :address

## address

| Column         | Type    | Options     |
|----------------|---------|-------------|
| postal_code    | integer | null: false |
| prefectures    | string  | null: false |
| municipalities | string  | null: false |
| address_code   | integer | null: false |
| building_name  | string  |             |
| phone_number   | integer | null: false |

### Association
- belongs_to :purchase_log
