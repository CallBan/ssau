<template>
  <div class="card my-2" @click="goToPost(topic, discussion)">
    <div class="card-body">
      <h5 class="card-title">{{ discussion.title }}</h5>
      <p class="card-text">{{ discussion.fullDescription }}</p>
      <p class="card-text">
        <small class="text-muted">Опубликовано: {{ discussion.publicationDate }}</small>
      </p>
      <p class="card-text">
        <span :class="statusClass">{{ discussion.status }}</span>
      </p>
    </div>
  </div>
</template>

<script setup>
import { defineProps, computed } from "vue";
import { useRouter } from "vue-router";

const router = useRouter();

const props = defineProps({
  discussion: {
    type: Object,
    required: true,
  },
  topic: {
    type: Object,
    required: true,
  },
  id: String,
});

const statusClass = computed(() => {
  return {
    badge: true,
    "bg-success": props.discussion.status === "Проверено",
    "bg-warning": props.discussion.status !== "Проверено",
  };
});

const goToPost = (topic, discussion) => {
  router.push({ name: "Post", params: { id_topic: topic.id, id_post: discussion.id } });
};
</script>
