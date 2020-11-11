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
          <b-form-input v-model="card.japanese_text" class="text-center" @blur="$emit('update', card)" />
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
      <b-collapse :id="'accordion-' + card.id" role="tabpanel">
        <b-card-body>
          <!-- english text -->
          <div class="position-relative">
            <b-collapse :id="'collapse-' + card.id" class="position-absolute card-inner-input">
              <b-form-input v-model="card.english_text" @blur="$emit('update', card)" />
            </b-collapse>
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
            <b-collapse :id="'collapse-' + card.id" class="position-absolute card-inner-input">
              <b-form-textarea
                v-model="card.note"
                placeholder="Enter note"
                no-resize
                @blur="$emit('update', card)"
              />
            </b-collapse>
            <b-card-text :id="'note' + card.id">
              {{ card.note }}
            </b-card-text>
          </div>
          <!-- source -->
          <div class="position-relative mb-4">
            <b-collapse :id="'collapse-' + card.id" class="position-absolute card-inner-input">
              <b-form-input v-model="card.source" placeholder="Enter source" @blur="$emit('update', card)" />
            </b-collapse>
            <!-- eslint-disable-next-line vue/no-v-html -->
            <b-card-text :id="'source' + card.id" v-html="link(card.source)" />
          </div>
          <div class="d-flex justify-content-between">
            <div class="buttons-left">
              <!-- edit -->
              <b-button v-b-toggle="'collapse-' + card.id" variant="dark">
                edit
              </b-button>
              <!-- detail -->
              <router-link :to="{ name: 'CardShow', params: {id: card.id} }">
                <b-button variant="dark">
                  detail
                </b-button>
              </router-link>
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
                <b-button v-if="!(card.done)" variant="success" @click="$emit('done', card)">
                  done
                </b-button>
              </b-button-group>
              <!-- review timing -->
              <div v-if="!(card.done)">
                <div v-if="reviewTimings[card.phase] == 1">
                  shown tomorrow
                </div>
                <div v-else>
                  shown {{ reviewTimings[card.phase] }} days later
                </div>
              </div>
              <div v-else>
                <div v-if="reviewTiming(card.phase, card.done_time) == 1">
                  shown tomorrow
                </div>
                <div v-else>
                  shown {{ reviewTiming(card.phase, card.done_time) }} days later
                </div>
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
import moment from 'moment';

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
      reviewTimings: document.getElementById('review_timings').value.split(','),
    };
  },
  computed: {

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
    reviewTiming(phase, done_time) {
      var today = moment(document.getElementById('current_server_date').value);
      var done = moment(done_time);
      return this.reviewTimings[phase] - today.diff(done, 'days');
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
