<template>
  <div id="app">
    <b-container>
      <card-form @add="addCard" />

      <div class="accordion" role="tablist">
        <b-card no-body class="mb-1" v-for="card in userCards" :key="card.id">
          <!-- japanese text -->
          <b-card-header header-tag="header" class="p-1" role="tab">
            <b-button block v-b-toggle="'accordion-' + card.id" variant="info" class="position-relative" @click="link(card)">
              {{ card.japanese_text }}
              <b-collapse :id="'collapse-' + card.id" class="position-absolute">
                <b-form-input v-model="card.japanese_text" @blur="updateCard(card)"></b-form-input>
              </b-collapse>
            </b-button>
          </b-card-header>
          <!-- hidden english text & source-->
          <b-collapse :id="'accordion-' + card.id" accordion="my-accordion" role="tabpanel">
            <b-card-body>
              <!-- english text -->
              <b-card-text class="position-relative">
                {{ card.english_text }}
                <b-collapse :id="'collapse-' + card.id" class="position-absolute">
                  <b-form-input v-model="card.english_text" @blur="updateCard(card)"></b-form-input>
                </b-collapse>
              </b-card-text>
              <!-- source -->
              <b-card-text :id="'source' + card.id" class="position-relative" v-html="card.source">
                <!-- {{ card.source }} -->
                <b-collapse :id="'collapse-' + card.id" class="position-absolute">
                  <b-form-input v-model="card.source" @blur="updateCard(card)"></b-form-input>
                </b-collapse>
              </b-card-text>
              <!-- detail -->
            <b-card-text><router-link :to="{ name: 'CardShow', params: {id: card.id } }"  >detail</router-link></b-card-text>
              <!-- edit -->
              <b-button v-b-toggle="'collapse-' + card.id">edit</b-button>
              <!-- destroy -->
              <b-button variant="danger" @click="destroyCard(card)">delete</b-button>
            </b-card-body>
          </b-collapse>
        </b-card>
      </div>
    </b-container>
  </div>
</template>

<script>
  import axios from 'axios';
  import {reject} from 'lodash';
  import Autolinker from 'autolinker';

  import CardForm from '../cards/CardForm.vue';

  export default {
    data() {
      return {
        cards: []
      }
    },
    mounted() {
      // source1.innerHTML = Autolinker.link(this.$refs.source1.innerHTML);
      axios.get('/api/v1/cards.json')
        .then(res => (this.cards = res.data));
    },
    components: {
      CardForm
    },
    computed: {
      userCards: function(){
        return this.cards.filter(function(card){
          return card.user_id == document.getElementById('current_user_id').value
        }, this);
      }
    },
    methods: {
      addCard(card) {
        this.cards.push(card)
      },
      updateCard(card) {
        axios.patch('/api/v1/cards/' + card.id, {card: card})
          .then(res => {
            if (res.status === 200) {
              console.log(res)
            }
          })
      },
      destroyCard(card) {
        axios.delete('/api/v1/cards/' + card.id)
        .then(res => {
          if (res.status === 200){
            this.cards = reject(this.cards, ['id', card.id]);
          }
        });
      },
      link(card) {
        card.source = Autolinker.link(card.source);
      }
    }
  }
</script>

<style scoped>
  .position-relative{
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
  }

  .position-absolute{
    top: -1px;
    left: -1px;
  }
</style>
