<template id="">
  <div>
    <dl class="row">
      <dt class="col-sm-3">
        japanese
      </dt>
      <dd class="col-sm-9">
        {{ card.japanese_text }}
      </dd>

      <dt class="col-sm-3">
        english
      </dt>
      <dd class="col-sm-9">
        {{ card.english_text }}
      </dd>

      <dt class="col-sm-3">
        source
      </dt>
      <!-- eslint-disable-next-line vue/no-v-html -->
      <dd class="col-sm-9" v-html="link(card.source)" />

      <dt class="col-sm-3">
        done
      </dt>
      <dd class="col-sm-9">
        <span v-if="card.done_time">
          {{ card.done_time | moment }}
        </span>
        <span v-else>
          never done
        </span>
      </dd>

      <dt class="col-sm-3">
        created
      </dt>
      <dd class="col-sm-9">
        {{ card.created_at | moment }}
      </dd>

      <dt class="col-sm-3">
        updated
      </dt>
      <dd class="col-sm-9">
        {{ card.updated_at | moment }}
      </dd>
    </dl>

    <router-link to="/">
      <b-button variant="dark">
        back
      </b-button>
    </router-link>
  </div>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import Autolinker from 'autolinker';
import sanitizeHTML from 'sanitize-html';

var autolinker = new Autolinker( {
  email       : false,
  phone       : false,
  stripPrefix : false,
});

export default {
  filters: {
    moment(date) {
      return moment (date).format('YYYY/MM/DD');
    }
  },
  data() {
    return {
      card: []
    };
  },
  mounted() {
    axios.get(`/api/v1/cards/${this.$route.params.id}.json`)
      .then(res => (this.card = res.data));
  },
  methods: {
    link(source) {
      return sanitizeHTML(autolinker.link(source));
    }
  }
};
</script>

<style scoped>
</style>
