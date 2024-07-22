<template>
    <div class="container">
        <Emoji
            v-for="emoji of emojis"
            :emoji="emoji"
            @click="emit('selectEmoji', emoji)"
        />
    </div>
</template>

<script setup>
import Emoji from "./Emoji.vue";
import { defineProps, defineEmits } from "vue";

const props = defineProps({
    emojis: { type: Array, required: true, default: () => [] },
});

const emit = defineEmits(["selectEmoji"]);
</script>

<style scoped>
.container {
    display: grid;
    grid-template-columns: repeat(6, 1fr);
    font-size: 3rem;
}
</style>
