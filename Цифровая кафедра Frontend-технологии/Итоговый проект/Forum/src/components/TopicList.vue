<template>
  <div class="container my-5">
    <TopicCard v-for="topic in topics" :topic="topic" :key="topic.id" />
  </div>
</template>

<script setup>
import { topics } from "@/data/data";
import TopicCard from "./TopicCard.vue";
</script>
