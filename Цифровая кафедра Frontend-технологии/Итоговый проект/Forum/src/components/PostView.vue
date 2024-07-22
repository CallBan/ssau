<template>
    <div class="container my-3">
        <div class="post-header">
            <h1>{{ post.title }}</h1>
            <span :class="statusClass">{{ post.status }}</span>
            <p class="text-muted">Дата публикации: {{ post.publicationDate }}</p>
        </div>
        <div class="post-body">
            <p>{{ post.fullDescription }}</p>
        </div>
    </div>
    <div class="container mu-3">
        <Comment v-for="comment in post.comments" :comment="comment" :key="comment" />
    </div>
    <div v-if="post.status === 'Проверено'" class="container my-2">
        <div class="btn btn-lg btn-outline-primary w-100" @click="goToCreate(topic, post)">
            +
        </div>
    </div>
    <div v-else class="container alert alert-info" role="alert">
        Это обсуждение можно будет комментировать, когда оно пройдет проверку модератором.
    </div>
</template>

<script setup>
import { computed, defineProps } from "vue";
import { useRouter } from "vue-router";
import { topics } from '@/data/data';
import Comment from "./Comment.vue";

const router = useRouter();

const props = defineProps({
    id_topic: String,
    id_post: String,
});

const topic = computed(() => {
    return topics.find((topicItem) => topicItem.id === Number(props.id_topic));
})

const post = computed(() => {
    return topic.value.discussions.find((discussionItem) => discussionItem.id === Number(props.id_post))
});

let statusClass = computed(() => {
    return {
        badge: true,
        "bg-success": post.value.status === "Проверено",
        "bg-warning": post.value.status !== "Проверено",
    };
});

const goToCreate = (topic, post) => {
    console.log(topic.id, post.id);
    router.push({ name: "CreateComment", params: { id_topic: topic.id, id_post: post.id } });
};
</script>

<style scoped>
.post-header h1 {
    font-size: 1.75rem;
    margin-bottom: 0.5rem;
}

.post-body {
    font-size: 1rem;
    line-height: 1.5;
}
</style>