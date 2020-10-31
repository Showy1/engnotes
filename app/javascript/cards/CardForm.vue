<template id="">
  <div class="create_new_card">
    <b-form @submit="onSubmit" @reset="onReset" :model="card">
      <b-form-group id="input-group-1" label-for="input-1">
        <b-form-input
          id="input-1"
          v-model="card.japanese_text"
          type="text"
          required
          placeholder="Enter Japanese text"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-2" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="card.english_text"
          type="text"
          required
          placeholder="Enter English text"
        ></b-form-input>
      </b-form-group>

      <b-form-group id="input-group-3" label-for="input-3">
        <b-form-input
          id="input-3"
          v-model="card.source"
          type="text"
          placeholder="Enter source"
        ></b-form-input>
      </b-form-group>

      <b-button type="submit" variant="primary">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
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
          source: '',
        }
      }
    },
    methods: {
      onSubmit(evt) {
        evt.preventDefault()
        axios.post('/api/v1/cards', this.card)
          .then(res => {
            switch (res.status) {
              case 201:
                this.$emit('add', res.data)
                this.card = {
                  japaneseText: '',
                  englishText: '',
                  source: '',
                }
                break;
              case 400:
                console.log(res.data.message)
                break;
            }
          });
      },
      onReset(evt) {
        evt.preventDefault()
        this.form.email = ''
        this.form.name = ''
      }
    }
  }
</script>
