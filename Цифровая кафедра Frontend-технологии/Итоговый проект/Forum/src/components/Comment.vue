<template>
    <div class="card p-2 my-2">
        <div>
            <strong>{{ comment.author.nickname }}</strong>
            <span class="mx-2 badge bg-secondary">{{ comment.author.reputation }}</span>
        </div>
        <p>{{ comment.text }}</p>
    </div>

</template>

<script setup>
import { defineProps } from "vue";

const props = defineProps({
    comment: Object,
})

const comment = props.comment;
</script>

<style scoped>
.card:hover {
    background-color: white;
}
</style>