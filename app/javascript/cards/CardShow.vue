<template id="">
  <div class="container">
    <dl class="row">
      <dt class="col-sm-3">japanese</dt>
      <dd class="col-sm-9">{{ card.japanese_text }}</dd>

      <dt class="col-sm-3">english</dt>
      <dd class="col-sm-9">{{ card.english_text }}</dd>

      <dt class="col-sm-3">source</dt>
      <dd class="col-sm-9">{{ card.source }}</dd>

      <dt class="col-sm-3">created</dt>
      <dd class="col-sm-9">{{ card.created_at | moment }}</dd>

      <dt class="col-sm-3">updated</dt>
      <dd class="col-sm-9">{{ card.updated_at | moment }}</dd>
    </dl>
  </div>
</template>

<script>
  import axios from 'axios';
  import moment from 'moment';

  export default {
    data() {
      return {
        card: []
      }
    },
    mounted() {
      axios.get(`/api/v1/cards/${this.$route.params.id}.json`)
        .then(res => (this.card = res.data))
    },
    filters: {
      moment(date) {
        return moment (date).format('YYYY/MM/DD');
      }
    }
  }
</script>

<style scoped>
</style>
