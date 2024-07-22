<script setup>
import { defineProps } from "vue";

const props = defineProps({
    emoji: {
        type: Object,
        required: true,
    },
});
</script>

<template>
    <div v-html="props.emoji.htmlCode[0]"></div>
</template>
