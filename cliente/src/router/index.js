import { createRouter, createWebHistory } from 'vue-router';
import BuffetList from '../components/BuffetList.vue';
import BuffetDetail from '../components/BuffetDetails.vue';
import EventAvailability from '../components/EventTypeAvailability.vue';

const routes = [
    { path: '/', component: BuffetList },
    { path: '/buffet/:id', component: BuffetDetail, props: true },
    { path: '/buffet/:buffetId/event/:eventTypeId', component: EventAvailability, props: true },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;
