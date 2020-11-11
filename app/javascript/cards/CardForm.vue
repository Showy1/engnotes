<template id="">
  <div class="create_new_card">
    <b-form @submit="onSubmit" @reset="onReset">
      <b-form-group label-for="input_japanese_text">
        <b-form-input
          id="input_japanese_text"
          v-model="card.japanese_text"
          type="text"
          required
          placeholder="Enter Japanese text *required"
        />
      </b-form-group>

      <b-form-group label-for="input_english_text">
        <b-form-input
          id="input_english_text"
          v-model="card.english_text"
          type="text"
          required
          placeholder="Enter English text *required"
        />
      </b-form-group>

      <b-form-group label-for="textarea_note">
        <b-form-textarea
          id="textarea_note"
          v-model="card.note"
          type="text"
          placeholder="Enter note"
          no-resize
        />
      </b-form-group>

      <b-form-group label-for="input_source">
        <b-form-input
          id="input_source"
          v-model="card.source"
          type="text"
          placeholder="Enter source"
        />
      </b-form-group>

      <b-button type="submit" variant="primary">
        Submit
      </b-button>
      <b-button type="reset" variant="danger">
        Reset
      </b-button>
    </b-form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      card: {
        japaneseText: '',
        englishText: '',
        note: '',
        source: '',
      }
    };
  },
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      axios.post('/api/v1/cards', this.card)
        .then(res => {
          switch (res.status) {
          case 201:
            this.$emit('add', res.data);
            this.card = {
              japaneseText: '',
              englishText: '',
              note: '',
              source: '',
            };
            break;
          case 400:
            break;
          }
        });
    },
    onReset(evt) {
      evt.preventDefault();
      this.card.japanese_text = '';
      this.card.english_text = '';
      this.card.note = '';
      this.card.source = '';
    }
  }
};
</script>
