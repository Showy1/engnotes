# README APP Title

## 概要
英語フレーズ暗記用のWebアプリです。  
英文読み上げ機能を有する英語暗記カードを作成できます。  
確認した暗記カードを数日後に再表示し、フレーズを定着させます。

主に **Ruby (2.7), Rails (6.0), Vue.js (2.6)** を使用しました。

## 機能および主要関連技術

* 暗記カードのCRUD / 暗記カード確認後、数日後に再表示 - **Vue.js, Ruby on Rails, axios**

* ユーザーのCRUDとメール認証 / ゲストログイン - **devise**

* 英文読み上げ - Web Speech API

* 暗記カードの検索 - Vue.js

* 暗記カードのソート - Vue.js, Lodash

## 開発用技術

* テスト - **RSpec, Capybara**

* 静的テスト - **RuboCop, ESLint**

* models等への自動コメント - annotate

## インフラ構成

<div style="color: red;">要追加</div>

## 技術一覧

* フロントエンド - **Vue.js,** Vue Router, **axios, Webpacker,** BootstrapVue, Lodash, Moment.js, sanitize-html, Bootstrap, Font Awesome, jQuery, ESLint

* バックエンド - **Ruby on Rails, MySQL, devise, RSpec, Capybara,** RuboCop

* インフラ - **AWS (EC2, VPC), Docker,** Puma, NGINX

## インストール

```
$ git clone https://github.com/Showy1/memorization_app.git
$ cd memorization_app
$ docker-compose build
```
