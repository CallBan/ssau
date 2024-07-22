<template>
  <div class="card my-2" @click="goToTopic(topic)">
    <div class="card-body">
      <h5 class="card-title">{{ topic.title }}</h5>
      <p class="card-text">{{ topic.description }}</p>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from "vue";
import { useRouter } from "vue-router";

const props = defineProps({
  topic: {
    type: Object,
    required: true,
  },
});

const router = useRouter();

const goToTopic = (topic) => {
  router.push({ name: "Topic", params: { id: topic.id } });
};
</script>

<style>
.card:hover {
  background-color: #ebebeb;
}
</style>
