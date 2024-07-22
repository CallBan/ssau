<template>
    <div class="game">
        <EmojiList
            :emojis="emojis"
            @selectEmoji="handleSelectEmoji($event, 0)"
        />
        <EmojiMixed
            :firstEmoji="selectedEmojis[0]"
            :secondEmoji="selectedEmojis[1]"
        />
        <EmojiList
            :emojis="emojis"
            @selectEmoji="handleSelectEmoji($event, 1)"
        />
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import EmojiMixed from "./EmojiMixed.vue";
import EmojiList from "./EmojiList.vue";

const emojis = ref([]);
const selectedEmojis = ref([null, null]);

onMounted(() => {
    loadEmojis();
});

function handleSelectEmoji(emoji, index) {
    selectedEmojis.value[index] = emoji;
}

async function loadEmojis() {
    try {
        const response = await fetch(`https://emojihub.yurace.pro/api/all`);
        const data = await response.json();
        emojis.value = data;
        selectedEmojis.value = [data[2], data[4]];
    } catch {
        alert("ошибка");
    }
}
</script>
<style scoped>
.game {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
}
</style>
