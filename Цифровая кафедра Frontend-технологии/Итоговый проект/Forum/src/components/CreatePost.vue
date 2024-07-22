<template>
    <div class="container my-4">
        <h3>{{ topic.title }}</h3>
        <hr />
        <div class="mb-3">
            <input type="text" :class="{ 'is-invalid': isTitleEmpty }" class="form-control"
                placeholder="Введите заголовок обсуждения" v-model="title">
        </div>
        <div class="mb-3">
            <textarea :class="{ 'is-invalid': isDescriptionEmpty }" class="form-control" rows="5"
                placeholder="Введите описание обсуждения" v-model="description"></textarea>
        </div>
        <button type="submit" class="btn btn-primary w-100" @click="addDiscussion(topic)">Создать
            обсуждение</button>
    </div>
</template>

<script setup>
import { computed, defineProps, ref } from "vue";
import { useRouter } from "vue-router";
import { topics } from "@/data/data";
import { getDiscussionId, getCurrentDate } from "@/data/data-utils";

const title = ref("");
const description = ref("");
const isTitleEmpty = ref(false);
const isDescriptionEmpty = ref(false);
const router = useRouter();

const props = defineProps({
    id: String,
});

const topic = computed(() => {
    return topics.find((topicItem) => topicItem.id === Number(props.id));
});

const addDiscussion = (topic) => {
    let isValid = true;
    if (title.value.trim() === "") {
        isTitleEmpty.value = true;
        isValid = false;
    } else {
        isTitleEmpty.value = false;
    }

    if (description.value.trim() === "") {
        isDescriptionEmpty.value = true;
        isValid = false;
    } else {
        isDescriptionEmpty.value = false;
    }

    if (!isValid) return;
    topic.discussions.push({
        id: getDiscussionId(),
        title: title.value,
        fullDescription: description.value,
        publicationDate: getCurrentDate(),
        status: "На рассмотрении",
        comments: []
    })
    router.back();
};
</script>