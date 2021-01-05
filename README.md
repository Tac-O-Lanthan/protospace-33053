# README

# テーブル設計

## users テーブル

| Columna      | Type   | Options     |
| ------------ | ------ | ----------- |
| email        | string | null: false |
| password     | string | null: false |
| name         | string | null: false |
| profile      | text   | null: false |
| occupation   | text   | null: false |
| position     | text   | null: false |

### Association

- has_many :prototypes
- has_many :comments

## prototypes テーブル

| Column     | Type       | Options     |
| ---------- | ---------- | ----------- |
| title      | string     | null: false |
| catch_copy | text       | null: false |
| concept    | text       | null: false |
| image      |            |             |
| user       | references |             |

### Association

- belongs_to :users
- has_many :comments

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| text      | text       | null: false, foreign_key: true |
| user      | references |                                |
| protorype | references |                                |

### Association

- belongs_to :room
- belongs_to :user