<template>
  <div class="accordion" role="tablist">
    <b-card
      v-for="card in filteredCards"
      :key="card.id"
      class="mb-1"
      no-body
    >
      <!-- japanese text -->
      <b-card-header
        header-tag="header"
        class="p-1 position-relative"
        role="tab"
        @keyup.83.ctrl="speak(card.english_text)"
      >
        <!-- <b-button
          v-b-toggle="'accordion-' + card.id"
          variant="info"
          block
        >
          {{ card.japanese_text }}
        </b-button> -->
        <div v-if="card.japanese_text">
          <b-collapse :id="'collapse-' + card.id" class="position-absolute w-100" style="top: 4px; left: 0;">
            <b-form-input v-model="card.japanese_text" class="text-center" @blur="$emit('update', card)" />
          </b-collapse>
          <b-button
            v-b-toggle="'accordion-' + card.id"
            variant="info"
            block
          >
            {{ card.japanese_text }}
          </b-button>
        </div>
        <div v-else-if="card.youtube_id">
          <b-button
            v-b-toggle="'accordion-' + card.id"
            class="py-5 px-0"
            variant="info"
            block
          >
            <b-embed
              type="iframe"
              aspect="16by9"
              :src="'https://www.youtube.com/embed/' + card.youtube_id"
              allowfullscreen
            />
          </b-button>
        </div>
        <div v-else>
          <b-button
            v-b-toggle="'accordion-' + card.id"
            variant="info"
            block
          >
            error
          </b-button>
        </div>
      </b-card-header>
      <!-- hidden english text & source-->
      <b-collapse :id="'accordion-' + card.id" role="tabpanel">
        <b-card-body>
          <!-- english text -->
          <div class="position-relative">
            <b-card-text>
              {{ card.english_text }}
              <!-- speak -->
              <b-button class="d-block ml-auto mr-0" variant="dark" @click="speak(card.english_text)">
                <i class="fas fa-volume-up" />
              </b-button>
            </b-card-text>
          </div>
          <!-- note -->
          <div class="position-relative mb-5">
            <b-card-text :id="'note' + card.id">
              {{ card.note }}
            </b-card-text>
          </div>
          <!-- source -->
          <div class="position-relative mb-4">
            <!-- eslint-disable-next-line vue/no-v-html -->
            <b-card-text :id="'source' + card.id" v-html="link(card.source)" />
          </div>
          <!-- detail -->
          <router-link :to="{ name: 'CardShow', params: {id: card.id} }">
            <b-button variant="dark">
              detail
            </b-button>
          </router-link>
        </b-card-body>
      </b-collapse>
    </b-card>
  </div>
</template>

<script>
import Autolinker from 'autolinker';
import sanitizeHTML from 'sanitize-html';

var autolinker = new Autolinker( {
  email       : false,
  phone       : false,
  stripPrefix : false,
});

export default {
  props: {
    filteredCards: {
      type: Array,
      default: () => []
    }
  },
  methods: {
    speak(english_text) {
      var speak = new SpeechSynthesisUtterance();
      speak.text = english_text;
      speak.lang = 'en';
      speechSynthesis.speak(speak);
    },
    link(source) {
      return sanitizeHTML(autolinker.link(source));
    }
  }
};
</script>

<style scoped>
p.card-text {
  padding: 0.375rem 0.75rem;
}

.card-inner-input {
  width: 100%;
  top: -1px;
  left: -1px;
}

.show + button,
.show + p.card-text {
  pointer-events: none;
  opacity: 0;
}
</style>
