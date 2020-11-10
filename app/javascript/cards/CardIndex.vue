<template>
  <div id="app">
    <b-container>
      <b-card no-body>
        <b-tabs pills card>
          <b-tab title="Top" active>
            Hello
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
    </b-container>
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
