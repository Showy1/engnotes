<template>
  <div id="app">
    <b-container>
      <card-form @add="addCard" />

      <b-form @reset="onReset">
        <b-form-input id="input_search" v-model="keyword" type="text" />
        <b-button id="search_reset" type="reset" variant="danger">
          Reset
        </b-button>
      </b-form>

      <b-tabs
        active-nav-item-class="font-weight-bold text-uppercase text-danger"
        active-tab-class="font-weight-bold text-success"
        content-class="mt-3"
      >
        <b-tab title="Undone" active>
          <card-table
            :filtered-cards="filter(filteredCards, false)"
            @update="updateCard"
            @destroy="destroyCard"
            @done="done"
            @link="link"
          />
        </b-tab>
        <b-tab title="Done" @click="get">
          <card-table
            :filtered-cards="filter(filteredCards, true)"
            @update="updateCard"
            @destroy="destroyCard"
          />
        </b-tab>
      </b-tabs>
    </b-container>
  </div>
</template>

<script>
import axios from 'axios';
import {reject, filter} from 'lodash';
import Autolinker from 'autolinker';

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
    // source1.innerHTML = Autolinker.link(this.$refs.source1.innerHTML);
    this.get();
  },
  methods: {
    get() {
      axios.get('/api/v1/cards.json')
        .then(res => (this.cards = res.data));
    },
    addCard(card) {
      this.cards.push(card);
    },
    updateCard(card) {
      axios.patch('/api/v1/cards/' + card.id, {card: card})
        .then(res => {
          if (res.status === 200) {
            console.log(res);
          }
        });
    },
    destroyCard(card) {
      axios.delete('/api/v1/cards/' + card.id)
        .then(res => {
          if (res.status === 200){
            this.cards = reject(this.cards, ['id', card.id]);
          }
        });
    },
    done(card) {
      axios.patch('/api/v1/cards/' + card.id, {
        done: true,
        done_time: document.getElementById('current_server_date').value
      })
        .then(res => {
          if (res.status === 200) {
            this.cards = reject(this.cards, ['id', card.id]);
            console.log(res);
          }
        });
    },
    filter(cards, boolean) {
      return filter(cards, ['done', boolean]);
    },
    link(card) {
      card.source = Autolinker.link(card.source);
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
