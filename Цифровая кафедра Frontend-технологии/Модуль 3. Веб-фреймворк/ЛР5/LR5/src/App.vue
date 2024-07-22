<script setup>
import { ref } from "vue";
let number = ref("");
let type = ref("trivia");
let result = ref("");
let dataIsLoading = ref(false);

async function searchFact() {
    dataIsLoading.value = true;
    try {
        const response = await fetch(
            `http://numbersapi.com/${number.value}/${type.value}?json`
        );
        const data = await response.json();
        if (data.found) {
            result.value = data.text;
        } else {
            result.value = `${number.value} - скучное число/скучный год`;
        }
    } catch {
        result.value = "Что-то пошло не так";
    }
    dataIsLoading.value = false;
    return result;
}
</script>

<template>
    <form class="container">
        <label for="number">Введите число:</label>
        <input type="number" name="number" v-model="number" />
        <select name="facts" id="facts" v-model="type">
            <option value="math">Факт из области математики</option>
            <option value="year">Факт о введенном годе</option>
            <option value="trivia" selected>Случайный факт о числе</option>
        </select>
        <input type="button" value="Поиск" v-on:click="searchFact" />
    </form>
    <div v-if="dataIsLoading">
        <div class="loader"></div>
    </div>
    <div v-else>
        <h3>{{ result }}</h3>
    </div>
</template>

<style scoped>
.container {
    display: flex;
    flex-direction: column;
    width: 300px;
    gap: 3px;
}

.loader {
    border: 5px solid #f3f3f3;
    border-top: 5px solid #3498db;
    border-radius: 50%;
    width: 50px;
    height: 50px;
    animation: spin 2s linear infinite;
}

@keyframes spin {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
}
</style>
