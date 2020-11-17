# EngNotes

[![top](https://user-images.githubusercontent.com/62195235/99233676-eb8a8180-2836-11eb-88ba-7f7acd5e033d.png)](https://engnotes.net)

## 目次

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [概要](#%E6%A6%82%E8%A6%81)
- [デモ](#%E3%83%87%E3%83%A2)
- [機能および主要関連技術](#%E6%A9%9F%E8%83%BD%E3%81%8A%E3%82%88%E3%81%B3%E4%B8%BB%E8%A6%81%E9%96%A2%E9%80%A3%E6%8A%80%E8%A1%93)
- [インフラ関連技術](#%E3%82%A4%E3%83%B3%E3%83%95%E3%83%A9%E9%96%A2%E9%80%A3%E6%8A%80%E8%A1%93)
- [開発用技術](#%E9%96%8B%E7%99%BA%E7%94%A8%E6%8A%80%E8%A1%93)
- [構成](#%E6%A7%8B%E6%88%90)
- [技術一覧](#%E6%8A%80%E8%A1%93%E4%B8%80%E8%A6%A7)
- [開発背景](#%E9%96%8B%E7%99%BA%E8%83%8C%E6%99%AF)
- [使用方法](#%E4%BD%BF%E7%94%A8%E6%96%B9%E6%B3%95)
- [ローカルへのインストール](#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E3%81%B8%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
- [その他](#%E3%81%9D%E3%81%AE%E4%BB%96)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 概要

EngNotes は、英語フレーズを暗記するためのWebアプリです。  
英文読み上げ機能を有する英語暗記カードを作成できます。  
確認した暗記カードは数日後に再表示されます。  
復習を重ねて、フレーズを定着させましょう。  
下記ページで公開しています。  
https://engnotes.net

主に **Ruby (2.7), Rails (6.0), Vue.js (2.6)** を使用し、部分的なSPAを構成しました。

## デモ

[![created and done a new card](https://user-images.githubusercontent.com/62195235/99228702-4ec4e580-2830-11eb-8869-b5c5bf2dd7b1.gif)](https://engnotes.net)

## 機能および主要関連技術

* 暗記カードのCRUD / 暗記カード確認後、数日後（1, 4, 7, 11, 15, 20, 30日後）に再表示 - **Vue.js, Ruby on Rails, axios**

* ユーザーのCRUD / メール認証 / ゲストログイン / セッション管理 - **devise, Ruby on Rails**

* 英文読み上げ - Web Speech API

* 暗記カードの検索 - Vue.js

* 暗記カードのソート - Vue.js, Lodash

* 自動リンク化 / サニタイズ - Autolinker.js, sanitize-html

## インフラ関連技術

* **AWS (EC2, VPC, Route 53), Docker,** Puma, Nginx, Let's Encrypt

## 開発用技術

* テスト - **RSpec, Capybara**

* 静的テスト - **RuboCop, ESLint**

* models等への自動コメント - annotate

## 構成

![structure](https://user-images.githubusercontent.com/62195235/99231012-605bbc80-2833-11eb-9c50-c90cc903d232.png)

## 技術一覧

* フロントエンド - **Vue.js,** Vue Router, **axios, Webpacker,** BootstrapVue, Lodash, Moment.js, Autolinker.js, sanitize-html, Bootstrap, Font Awesome, jQuery, ESLint

* バックエンド - **Ruby on Rails, MySQL, devise, RSpec, Capybara,** RuboCop

* インフラ - **AWS (EC2, VPC, Route 53), Docker,** Puma, Nginx, Let's Encrypt

## 開発背景

日本では、英語のスピーキングに苦手意識を持つ人々、あるいは、スピーキングが不得意な人々が多く存在する。実際、国際ビジネスコミュニケーション協会（IIBC）が行った、日本全国20代～50代のビジネスパーソン男女500名を対象とした「英語のスピーキングに関する実態と意識」に関する調査のサマリー[^1]には、下記のように記されている。

>● 英語の4技能において、スピーキングが一番難しいと回答した人は55.8%
また、一番伸ばしたいと思っているものにスピーキングと回答した人は66.6%

>● 自身の英語の発音に自信がないと回答した人は55.6%
また、自身の英語の発音に自信がないため、「英語で話したくない」と思ったことがある人は64.4%

[^1]: https://prtimes.jp/main/html/rd/p/000000026.000051295.html

また、彼らの多くは、英語力、特にスピーキング能力の向上について関心がある。実際、同サマリーには、下記のようにも記されている。

>● ネイティブのような発音で話せるようになりたいと思っている人は90.0%
ネイティブのような発音で話すことができるようになったら積極的に英語で外国人に話しかけたいと思っている人は89.2%

このように、日本において、英語学習市場に需要があることは明白である。  

英語のスピーキング能力を向上するためには、瞬時に英文を構成する能力が必要であることは言うまでもない。英語フレーズを瞬時に想起するためには、各々が使いたいフレーズに何度も触れ、それを思い出すプロセスが有効である。フレーズに触れる際には、単に英文を視認するだけでなく、同時に音声を確認することにより、情報インプット効率の向上が見込まれる。  

このため、学習者が英語フレーズを簡単にメモとして残し、それらを何度も思い出すプロセスを学習者に与えるアプリは、英語学習者にとって有益であり、需要があるものだと考えられる。以上のような理由で、開発者は、英文読み上げ機能を有する英語暗記カードを作成して何度も復習の機会を与えてくれる本アプリ "EngNotes" を開発した。

## 使用方法

EngNotes は、英語フレーズを暗記するためのWebアプリです。英文読み上げ機能を有するオリジナルの英語暗記カードを作成できます。確認した暗記カードは数日後に再表示されます。ここでは、アプリの主な機能の使用方法について説明します。必要に応じて、アプリを操作しながらご活用ください。  

"New" タブをクリックすると、新規カード作成フォームが表示されます。和文および英文、必要に応じてメモや情報ソース（URLなど）を入力して、 "Submit" してください。追加されたカードの和文が、下の "Undone" タブ上に表示されます。表示された和文をクリックすると、英文、メモ、情報ソースと、各処理のためのボタンが表示されます。情報ソースがURLの場合、自動でリンク化されます。英語フレーズを覚えていれば "done" ボタン、覚えていなければ "redo" ボタンを押しましょう。"done" ボタンを押されたカードは、一時 "Done" タブ上に移動しますが、数日後（1回目は翌日、2回目は4、3回目は7、4回目は11、5回目は15、6回目は20、以降は30日後）に "Undone" タブ上に再表示されます。 "redo" ボタンを押されたカードは、 "Undone"/"Done" タブ切り替え後等に、"Undone" タブ上に再表示されます。その他の処理として、右のスピーカーボタンで英文読み上げ、 "edit" ボタンでカード編集、 "detail" ボタンでカード詳細ページへ移動、 "delete" ボタンでカード削除が可能です。  

"Search" タブをクリックすると、カード検索フォームが表示されます。フォームに入力した文字列を和文または英文として含むカードが、即座に表示されます。  

"Sort" タブをクリックすると、カードソートボタンが表示されます。 "shuffle" でランダムに、 "newest" で新しいカードを上位に、 "oldest" で古いカードを上位に表示することができます。  

また、ショートカットとして、下記が有効です。  

* カードの "done": カードの和文にフォーカスされた状態で "control" + "Enter"

* カードの "redo": カードの和文にフォーカスされた状態で "control" + "r"

* カードの英文読み上げ: カードの和文にフォーカスされた状態で "control" + "s"

説明は以上です。様々な英語フレーズを定着させて、英語力を向上させましょう。

## ローカルへのインストール

```
$ git clone https://github.com/Showy1/memorization_app.git
$ cd memorization_app
$ docker-compose build
$ docker-compose run app rails db:create
$ docker-compose run app rails db:migrate
```

## その他

開発中・随時更新
