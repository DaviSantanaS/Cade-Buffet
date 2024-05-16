<template>
  <div>
    <h2>Consultar Disponibilidade</h2>
    <form @submit.prevent="checkAvailability">
      <input v-model="eventDate" type="date" required>
      <input v-model="guestCount" type="number" required placeholder="Número de convidados">
      <button type="submit">Consultar</button>
    </form>
    <div v-if="availability !== null">
      <p v-if="availability.available">Disponível! Preço estimado: {{ availability.estimated_price }}</p>
      <p v-else>{{ availability.error }}</p>
    </div>
    <button @click="backToDetails">Voltar</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: ['buffetId', 'eventTypeId'],
  data() {
    return {
      eventDate: '',
      guestCount: '',
      availability: null
    };
  },
  methods: {
    checkAvailability() {
      axios.post(`http://localhost:3000/api/v1/buffets/${this.buffetId}/event_types/${this.eventTypeId}/check_availability`, {
        event_date: this.eventDate,
        guest_count: this.guestCount
      })
          .then(response => {
            this.availability = response.data;
          })
          .catch(error => {
            this.availability = error.response.data;
          });
    },
    backToDetails() {
      this.$router.push(`/buffet/${this.buffetId}`);
    }
  }
};
</script>

<style scoped>
h2 {
  text-align: center;
}
form {
  display: flex;
  flex-direction: column;
  align-items: center;
}
input {
  margin-bottom: 10px;
  padding: 10px;
  width: 80%;
}
</style>
