<template>
    <div class="container my-4">
        <h4>{{ post.title }}</h4>
        <div class="my-3">
            <Comment v-for="comment in post.comments" :comment="comment" :key="comment" />
        </div>
        <textarea class="form-control" :class="{ 'is-invalid': isCommentEmpty }" rows="5"
            placeholder="Введите комментарий" v-model="text"></textarea>
        <button type="submit" class="btn btn-primary mt-2" @click="addComment(post)">Создать комментарий</button>
    </div>
</template>

<script setup>
import { computed, defineProps, ref } from "vue";
import { useRouter } from "vue-router";
import { topics } from "@/data/data";
import Comment from "./Comment.vue";

const text = ref('');
const isCommentEmpty = ref(false);
const router = useRouter();

const props = defineProps({
    id_topic: String,
    id_post: String,
});

const topic = computed(() => {
    console.log(props.id_topic);
    return topics.find((topicItem) => topicItem.id === Number(props.id_topic));
});

const post = computed(() => {
    return topic.value.discussions.find((discussionItem) => discussionItem.id === Number(props.id_post))
});

const addComment = (post) => {
    if (text.value.trim() === '') {
        isCommentEmpty.value = true;
    }
    else {

        post.comments.push({
            author: {
                nickname: "User",
                email: "user@example.com",
                reputation: 0,
            },
            text: text.value,
            tags: [],
        });
        router.back();
    }
}
</script>