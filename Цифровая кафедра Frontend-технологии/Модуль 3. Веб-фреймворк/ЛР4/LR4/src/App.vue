<script setup>
import { ref, computed } from "vue";
let history = ref([]);
let title = ref("");
let amount = ref("");
let id = 1;

let incomeBalance = computed(() => {
    return history.value.reduce((sum, item) => {
        return item.amount > 0 ? sum + item.amount : sum;
    }, 0);
});

let outcomeBalance = computed(() => {
    return Math.abs(
        history.value.reduce((sum, item) => {
            return item.amount < 0 ? sum + item.amount : sum;
        }, 0)
    );
});

let totalBalance = computed(() => {
    return incomeBalance.value - outcomeBalance.value;
});

function addWaste() {
    history.value.push({
        text: title.value,
        amount: amount.value,
        id: id,
    });
    id += 1;
}
</script>

<template>
    <h1>Учет расходов</h1>
    <div v-if="history.length != 0">
        <h2>Баланс: {{ totalBalance }}</h2>
        <h2>Доходы: {{ incomeBalance }}</h2>
        <h2>Расходы: {{ outcomeBalance }}</h2>
        <ul>
            <li v-for="item in history" :key="item.id">
                <div>{{ item.text }}</div>
                <div v-if="item.amount > 0">{{ "+" + item.amount }}</div>
                <div v-else>{{ item.amount }}</div>
            </li>
        </ul>
    </div>
    <div v-else>
        <h2>Вы не совершали финансовых операций</h2>
    </div>
    <form class="form-container">
        <label for="text">Введите название:</label>
        <input type="text" text="text" v-model.trim="title" />
        <label for="amount">Введите сумму:</label>
        <input type="number" text="amount" v-model.number="amount" />
        <input type="button" value="Добавить" v-on:click="addWaste()" />
    </form>
</template>

<style scoped>
ul {
    padding: 0px;
    display: flex;
    flex-direction: column;
    gap: 2px;
}

li {
    list-style-type: none;
    display: flex;
    justify-content: space-between;
    width: 200px;
    border: solid 3px;
    padding: 2px;
}

.form-container {
    display: flex;
    flex-direction: column;
    width: 200px;
    gap: 5px;
}
</style>
