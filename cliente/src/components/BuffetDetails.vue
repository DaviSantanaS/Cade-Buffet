<template>
  <div v-if="buffet">
    <h1>{{ buffet.name }}</h1>
    <p>{{ buffet.description }}</p>
    <p>{{ buffet.address }}</p>
    <p>{{ buffet.phone }}</p>
    <p>{{ buffet.contact_email }}</p>
    <h2>Tipos de Eventos</h2>
    <ul>
      <li v-for="eventType in eventTypes" :key="eventType.id">
        <h3>{{ eventType.name }}</h3>
        <p>{{ eventType.description }}</p>
        <p>Capacidade: {{ eventType.min_capacity }} - {{ eventType.max_capacity }} pessoas</p>
        <p>Duração: {{ eventType.duration_minutes }} minutos</p>
        <p>Dias da semana: {{ formatDaysOfWeek(eventType.days_of_week) }}</p>
        <p>Bebidas alcoólicas: {{ eventType.has_alcoholic_beverages ? 'Sim' : 'Não' }}</p>
        <p>Decorações: {{ eventType.has_decorations ? 'Sim' : 'Não' }}</p>
        <p>Serviço de estacionamento: {{ eventType.has_parking_service ? 'Sim' : 'Não' }}</p>
        <p>Menu: {{ eventType.menu_text }}</p>
        <router-link :to="`/buffet/${buffet.id}/event/${eventType.id}`">Consultar preço</router-link>
      </li>
    </ul>
    <button @click="backToList">Voltar</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: ['id'],
  data() {
    return {
      buffet: null,
      eventTypes: []
    };
  },
  methods: {
    fetchBuffet() {
      axios.get(`http://localhost:3000/api/v1/buffets/${this.id}`)
          .then(response => {
            this.buffet = response.data;
            this.fetchEventTypes();
          });
    },
    fetchEventTypes() {
      axios.get(`http://localhost:3000/api/v1/buffets/${this.buffet.id}/event_types`)
          .then(response => {
            this.eventTypes = response.data;
          });
    },
    formatDaysOfWeek(days) {
      const daysOfWeek = ['Domingo', 'Segunda-feira', 'Terça-feira', 'Quarta-feira', 'Quinta-feira', 'Sexta-feira', 'Sábado'];
      return JSON.parse(days).map(day => daysOfWeek[day]).join(', ');
    },
    backToList() {
      this.$router.push('/');
    }
  },
  created() {
    this.fetchBuffet();
  }
};
</script>

<style scoped>
h1, h2 {
  text-align: center;
}
</style>
