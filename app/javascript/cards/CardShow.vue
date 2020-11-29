<template id="">
  <div>
    <dl>
      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          japanese
        </dt>
        <dd class="col-sm-9">
          {{ card.japanese_text }}
        </dd>
      </div>

      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          english
        </dt>
        <dd class="col-sm-9">
          {{ card.english_text }}
        </dd>
      </div>

      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          source
        </dt>
        <dd class="col-sm-9">
          <span v-if="card.source" v-html="link(card.source)" />
          <!-- eslint-disable-next-line vue/no-v-html -->
          <span v-else>
            none
          </span>
        </dd>
      </div>

      <div class="row w-100 border-bottom mb-2">
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
      </div>

      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          created by
        </dt>
        <dd class="col-sm-9" v-if="!loading">
          {{ card.user.username }}
        </dd>
      </div>

      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          created at
        </dt>
        <dd class="col-sm-9">
          {{ card.created_at | moment }}
        </dd>
      </div>

      <div class="row w-100 border-bottom mb-2">
        <dt class="col-sm-3">
          updated at
        </dt>
        <dd class="col-sm-9">
          {{ card.updated_at | moment }}
        </dd>
      </div>
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
      loading: false,
      card: []
    };
  },
  created() {
    this.loading = true;
  },
  mounted() {
    axios.get(`/api/v1/cards/${this.$route.params.id}.json`)
      // .then(res => (this.card = res.data), this.loading = false);
      .then(res => {
        this.card = res.data;
        this.loading = false;
      });
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
