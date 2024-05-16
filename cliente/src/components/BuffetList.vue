<template>
  <div>
    <h2>Lista de Buffets</h2>
    <input v-model="search" @input="fetchBuffets" placeholder="Buscar buffets...">
    <ul>
      <li v-for="buffet in buffets" :key="buffet.id">
        <router-link :to="`/buffet/${buffet.id}`">{{ buffet.name }}</router-link>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      search: '',
      buffets: []
    };
  },
  methods: {
    fetchBuffets() {
      axios.get(`http://localhost:3000/api/v1/buffets?search=${this.search}`)
          .then(response => {
            this.buffets = response.data;
          });
    }
  },
  created() {
    this.fetchBuffets();
  }
};
</script>

<style scoped>
h2 {
  text-align: center;
}
</style>
