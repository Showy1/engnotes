<template>
  <div id="app">
    <b-card no-body>
      <b-tabs pills card>
        <b-tab title="Top" active>
          Hello. <strong>Please click "Help" tab as necessary.</strong>
        </b-tab>
        <!-- new card form -->
        <b-tab title="New">
          <card-form @add="addCard" />
        </b-tab>
        <!-- search -->
        <b-tab title="Search">
          <b-form @reset="onReset">
            <b-form-group>
              <b-form-input id="input_search" v-model="keyword" type="text" />
            </b-form-group>
            <b-button id="search_reset" type="reset" variant="danger">
              Reset
            </b-button>
          </b-form>
        </b-tab>
        <!-- card -->
        <b-tab title="Sort">
          <!-- shuffle card -->
          <b-button variant="dark" @click="shuffle">
            shuffle
          </b-button>
          <!-- newest to oldest -->
          <b-button variant="dark" @click="newest">
            newest
          </b-button>
          <!-- oldest to newest -->
          <b-button variant="dark" @click="oldest">
            oldest
          </b-button>
        </b-tab>
        <b-tab>
          <template #title>
            <strong>Help</strong>
          </template>
          <p class="mb-2">
            EngNotes は、英語フレーズを暗記するためのWebアプリです。オリジナルの英語暗記カードを作成できます。確認した暗記カードは数日後に再表示されます。ここでは、アプリの主な機能の使用方法について説明します。
          </p>
          <p class="mb-2">
            "New" タブをクリックすると、新規カード作成フォームが表示されます。和文および英文、必要に応じてメモや情報ソース（URLなど）を入力して、 "Submit" してください。追加されたカードの和文が、下の "Undone" タブ上に表示されます。表示された和文をクリックすると、英文、メモ、情報ソースと、各処理のためのボタンが表示されます。情報ソースがURLの場合、自動でリンク化されます。英語フレーズを覚えていれば "done" ボタン、覚えていなければ "redo" ボタンを押しましょう。"done" ボタンを押されたカードは、一時 "Done" タブ上に移動しますが、数日後に "Undone" タブ上に再表示されます。 "redo" ボタンを押されたカードは、 "Undone"/"Done" タブ切り替え後等に、"Undone" タブ上に再表示されます。その他の処理として、右のスピーカーボタンで英文読み上げ、 "edit" ボタンでカード編集、 "detail" ボタンでカード詳細ページへ移動、 "delete" ボタンでカード削除が可能です。
          </p>
          <p class="mb-2">
            "Search" タブをクリックすると、カード検索フォームが表示されます。フォームに入力した文字列を和文または英文として含むカードが、即座に表示されます。
          </p>
          <p class="mb-2">
            "Sort" タブをクリックすると、カードソートボタンが表示されます。 "shuffle" でランダムに、 "newest" で新しいカードを上位に、 "oldest" で古いカードを上位に表示することができます。
          </p>
          <p class="mb-2">
            また、ショートカットとして、下記が有効です。
            <ul>
              <li>カードの "done": カードの和文にフォーカスされた状態で "control" + "Enter"</li>
              <li>カードの "redo": カードの和文にフォーカスされた状態で "control" + "r"</li>
              <li>カードの英文読み上げ: カードの和文にフォーカスされた状態で "control" + "s"</li>
            </ul>
          </p>
          <p>
            説明は以上です。様々な英語フレーズを定着させて、英語力を向上させましょう。
          </p>
        </b-tab>
      </b-tabs>
    </b-card>
    <!-- card table -->
    <b-card no-body>
      <b-tabs pills card>
        <b-tab
          title="Undone"
          active
          class="p-0"
          @click="get"
        >
          <card-table
            :filtered-cards="filter(filteredCards, false)"
            @update="updateCard"
            @destroy="destroyCard"
            @redo="redo"
            @done="done"
          />
        </b-tab>
        <b-tab title="Done" class="p-0" @click="get">
          <card-table
            :filtered-cards="filter(filteredCards, true)"
            @update="updateCard"
            @destroy="destroyCard"
            @redo="redo"
          />
        </b-tab>
      </b-tabs>
    </b-card>
  </div>
</template>

<script>
import axios from 'axios';
import {reject, filter, shuffle, orderBy} from 'lodash';

import CardForm from '../cards/CardForm.vue';
import CardTable from '../cards/CardTable.vue';

export default {
  components: {
    CardForm,
    CardTable
  },
  data() {
    return {
      keyword: '',
      cards: []
    };
  },
  computed: {
    filteredCards() {
      var cards = [];
      for(var i in this.cards) {
        var card = this.cards[i];
        if(card.japanese_text.indexOf(this.keyword) !== -1 || card.english_text.indexOf(this.keyword) !== -1) {
          cards.push(card);
        }
      }
      return cards;
    }
  },
  mounted() {
    this.get();
  },
  methods: {
    get() {
      axios.get('/api/v1/cards.json')
        .then(res => (this.cards = res.data));
    },
    addCard(card) {
      this.cards.unshift(card);
    },
    updateCard(card) {
      axios.patch('/api/v1/cards/' + card.id, {card: card});
    },
    destroyCard(card) {
      if (confirm('Are you sure you want to delete this card?')){
        axios.delete('/api/v1/cards/' + card.id)
          .then(res => {
            if (res.status === 200){
              this.cards = reject(this.cards, ['id', card.id]);
            }
          });
      }
    },
    shuffle() {
      this.cards = shuffle(this.cards);
    },
    newest() {
      this.cards = orderBy(this.cards, 'id', 'desc');
    },
    oldest() {
      this.cards = orderBy(this.cards, 'id', 'asc');
    },
    redo(card) {
      axios.patch('/api/v1/cards/' + card.id, {
        phase: 0,
        done: false,
      }).then(res => {
        if (res.status === 200) {
          this.cards = reject(this.cards, ['id', card.id]);
        }
      });
    },
    done(card) {
      axios.patch('/api/v1/cards/' + card.id, {
        done: true,
        done_time: document.getElementById('current_server_date').value
      }).then(res => {
        if (res.status === 200) {
          this.cards = reject(this.cards, ['id', card.id]);
        }
      });
    },
    filter(cards, boolean) {
      return filter(cards, ['done', boolean]);
    },
    onReset(evt) {
      evt.preventDefault();
      this.keyword = '';
    }
  }
};
</script>

<style scoped>
</style>
