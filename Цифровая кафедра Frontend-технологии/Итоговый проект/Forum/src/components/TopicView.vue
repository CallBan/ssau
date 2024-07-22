<template>
  <div class="container mu-5">
    <h2>{{ topic.title }}</h2>
    <p>{{ topic.description }}</p>
    <PostCard v-for="discussion in topic.discussions" :topic="topic" :discussion="discussion" :key="discussion.id" />
  </div>
  <div class="container mb-2">
    <div class="btn btn-lg btn-outline-primary w-100" @click="goToCreate(topic)">
      +
    </div>
  </div>
</template>

<script setup>
import { computed, defineProps } from "vue";
import { useRouter } from "vue-router";
import { topics } from "@/data/data";
import PostCard from "./PostCard.vue";

const props = defineProps({
  id: String,
});

const topic = computed(() => {
  return topics.find((topicItem) => topicItem.id === Number(props.id));
});

const router = useRouter();

const goToCreate = (topic) => {
  router.push({ name: "CreatePost", params: { id: topic.id } });
};
</script>
