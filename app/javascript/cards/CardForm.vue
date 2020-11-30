<template id="">
  <div class="create_new_card">
    <b-form @submit="onSubmit" @reset="onReset">
      <b-form-group>
        <b-form-radio-group
          v-model="selected"
          :options="options"
          name="radio-options"
        />
      </b-form-group>

      <div v-if="selected === 'text'">
        <b-form-group label-for="input_japanese_text">
          <b-form-input
            id="input_japanese_text"
            v-model="card.japanese_text"
            type="text"
            required
            placeholder="Enter Japanese text *required"
          />
        </b-form-group>
      </div>
      <div v-else-if="selected === 'video'">
        <b-form-group>
          <b-form-input
            v-model="youtubeURL"
            class="mb-1"
            type="url"
            required
            placeholder="Enter YouTube URL *required"
          />
          <div class="row">
            <div class="col-md-6 d-flex justify-content-end mb-1">
              <span style="padding: 0.375rem 0.75rem;">start</span>
              <b-form-input
                v-model.number="start_min"
                type="number"
                required
                min="0"
                max="720"
                placeholder="min"
                style="width: 77px;"
              />
              <span style="padding: 0.375rem 0.75rem;">:</span>
              <b-form-input
                v-model.number="start_sec"
                type="number"
                required
                min="0"
                max="59"
                placeholder="sec"
                style="width: 77px;"
              />
            </div>
            <div class="col-md-6 d-flex justify-content-end mb-1">
              <span style="padding: 0.375rem 0.75rem;">end</span>
              <b-form-input
                v-model.number="end_min"
                type="number"
                required
                min="0"
                max="720"
                placeholder="min"
                style="width: 77px;"
              />
              <span style="padding: 0.375rem 0.75rem;">:</span>
              <b-form-input
                v-model.number="end_sec"
                type="number"
                required
                min="0"
                max="59"
                placeholder="sec"
                style="width: 77px;"
              />
            </div>
          </div>
        </b-form-group>
      </div>

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
      selected: 'text',
      options: [
        { text: 'Japanese text', value: 'text' },
        { text: 'YouTube URL', value: 'video' },
      ],
      youtubeURL: '',
      start_min: 0,
      start_sec: 0,
      end_min: 0,
      end_sec: 0,
      card: {
        japaneseText: '',
        englishText: '',
        note: '',
        source: '',
      },
    };
  },
  computed: {
    time_query() {
      return '?start=' + (this.start_min * 60 + this.start_sec) + '&end=' + (this.end_min * 60 + this.end_sec);
    }
  },
  // watch: {
  //   youtubeURL(val) {
  //     this.card.youtubeId = val.slice(-11) + this.time_qyery;
  //   },
  //   time_query(val) {
  //     this.card.youtubeId = this.youtubeURL.slice(-11) + val;
  //   },
  // },
  methods: {
    onSubmit(evt) {
      evt.preventDefault();
      // this.card['youtube_id'] = this.youtubeURL.slice(-11) + "?start=" + (this.start_min * 60 + this.start_sec) + "&end=" + (this.end_min * 60 + this.end_sec);
      if(this.youtubeURL){
        this.card['youtube_id'] = this.youtubeURL.slice(-11) + this.time_query;
      }
      var posted_card = this.card;
      axios.post('/api/v1/cards', posted_card)
        .then(res => {
          switch (res.status) {
          case 201:
            this.$emit('add', res.data);
            this.youtubeURL = '';
            this.start_min = 0;
            this.start_sec = 0;
            this.end_min = 0;
            this.end_sec = 0;
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
      this.youtubeURL = '';
      this.start_min = 0;
      this.start_sec = 0;
      this.end_min = 0;
      this.end_sec = 0;
      this.card.english_text = '';
      this.card.note = '';
      this.card.source = '';
    }
  }
};
</script>
