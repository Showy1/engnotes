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
        @keyup.enter="$emit('done', card)"
        @keyup.83="speak(card.english_text)"
      >
        <b-collapse :id="'collapse-' + card.id" class="position-absolute w-100" style="top: 4px; left: 0;">
          <b-form-textarea v-model="card.japanese_text" @blur="$emit('update', card)" class="text-center" />
        </b-collapse>
        <b-button
          v-b-toggle="'accordion-' + card.id"
          variant="info"
          block
        >
          {{ card.japanese_text }}
        </b-button>
      </b-card-header>
      <!-- hidden english text & source-->
      <b-collapse :id="'accordion-' + card.id" accordion="my-accordion" role="tabpanel">
        <b-card-body>
          <!-- english text -->
          <div class="position-relative">
            <b-collapse :id="'collapse-' + card.id" />
            <b-card-text>
              {{ card.english_text }}
              <!-- speak -->
              <b-button class="d-block ml-auto mr-0" variant="dark" @click="speak(card.english_text)">
                <i class="fas fa-volume-up"></i>
              </b-button>
            </b-card-text>
            <b-collapse :id="'collapse-' + card.id" class="position-absolute">
              <b-form-textarea v-model="card.english_text" @blur="$emit('update', card)" />
            </b-collapse>
          </div>
          <!-- source -->
          <div class="position-relative">
            <!-- eslint-disable-next-line vue/no-v-html -->
            <b-card-text :id="'source' + card.id" v-html="link(card.source)" />
            <b-collapse :id="'collapse-' + card.id" class="position-absolute">
              <b-form-textarea v-model="card.source" @blur="$emit('update', card)" />
            </b-collapse>
          </div>
          <div class="d-flex justify-content-between">
            <div class="buttons-left">
              <!-- detail -->
              <router-link :to="{ name: 'CardShow', params: {id: card.id} }">
                <b-button variant="dark">
                  detail
                </b-button>
              </router-link>
              <!-- edit -->
              <b-button variant="dark" v-b-toggle="'collapse-' + card.id">
                edit
              </b-button>
              <!-- destroy -->
              <b-button variant="danger" @click="$emit('destroy', card)">
                delete
              </b-button>
            </div>

            <div class="buttons-right">
              <b-button-group size="lg">
                <!-- redo -->
                <b-button variant="warning" @click="$emit('redo', card)">
                  redo
                </b-button>
                <!-- done -->
                <b-button variant="success" @click="$emit('done', card)">
                  done
                </b-button>
              </b-button-group>
              <!-- review timing -->
              <div v-if="reviewTiming[card.phase] == 1">
                shown tomorrow
              </div>
              <div v-else>
                shown {{ reviewTiming[card.phase] }} days later
              </div>
            </div>
          </div>
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
  data() {
    return {
      reviewTiming: document.getElementById('review_timings').value.split(',')
    };
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
    },
  }
};
</script>

<style scoped>
p.card-text {
  /* height: calc(1.5em + 0.75rem + 2px); */
  padding: 0.375rem 0.75rem;
}

p.card-text + .position-absolute.collapse {
  width: 100%;
  top: -1px;
  left: -1px;
}

.show + button {
  pointer-events: none;
}

.show + p.card-text {
  /* opacity: 0; */
}

.show > input {
  pointer-events: auto;
}

textarea {
  resize: none;
}
</style>
