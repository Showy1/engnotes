<template>
  <div class="accordion" role="tablist">
    <!-- <b-card no-body class="mb-1" v-for="card in cards" :key="card.id"> -->
    <b-card no-body class="mb-1" v-for="card in filteredCards" :key="card.id">
      <!-- japanese text -->
      <b-card-header header-tag="header" class="p-1" role="tab">
        <b-button block v-b-toggle="'accordion-' + card.id" variant="info" class="position-relative" @click="$emit('link', card)">
          {{ card.japanese_text }}
          <b-collapse :id="'collapse-' + card.id" class="position-absolute">
            <b-form-input v-model="card.japanese_text" @blur="$emit('update', card)"></b-form-input>
          </b-collapse>
        </b-button>
      </b-card-header>
      <!-- hidden english text & source-->
      <b-collapse :id="'accordion-' + card.id" accordion="my-accordion" role="tabpanel">
        <b-card-body>
          <!-- english text -->
          <b-card-text class="position-relative">
            {{ card.english_text }}
            <!-- speak -->
            <b-button variant="info" @click="speak(card.english_text)">speak</b-button>
            <b-collapse :id="'collapse-' + card.id" class="position-absolute">
              <b-form-input v-model="card.english_text" @blur="$emit('update', card)"></b-form-input>
            </b-collapse>
          </b-card-text>
          <!-- source -->
          <b-card-text :id="'source' + card.id" class="position-relative" v-html="card.source">
            <!-- {{ card.source }} -->
            <b-collapse :id="'collapse-' + card.id" class="position-absolute">
              <b-form-input v-model="card.source" @blur="$emit('update', card)"></b-form-input>
            </b-collapse>
          </b-card-text>
          <!-- detail -->
        <b-card-text><router-link :to="{ name: 'CardShow', params: {id: card.id } }"  >detail</router-link></b-card-text>
          <!-- edit -->
          <b-button v-b-toggle="'collapse-' + card.id">edit</b-button>
          <!-- destroy -->
          <b-button variant="danger" @click="$emit('destroy', card)">delete</b-button>
          <!-- done -->
          <b-button variant="success" @click="$emit('done', card)">done</b-button>
        </b-card-body>
      </b-collapse>
    </b-card>
  </div>
</template>

<script>
  export default {
    // props: ['cards'],
    props: ['filteredCards'],
    methods: {
      speak(english_text){
      	var speak = new SpeechSynthesisUtterance();
        speak.text = english_text;
        speak.lang = 'en';
        speechSynthesis.speak(speak);
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
