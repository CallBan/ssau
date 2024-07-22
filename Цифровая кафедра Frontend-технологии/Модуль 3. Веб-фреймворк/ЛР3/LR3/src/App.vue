<template>
    <form class="form-container">
        <label for="name">Имя: </label>
        <input type="text" name="name" v-model="user.name" />
        <label for="name">Фамилия: </label>
        <input type="text" name="surname" v-model="user.surname" />
        <label for="gender">Пол:</label>
        <div class="gender">
            <label for="gender">Мужской </label>
            <input type="radio" name="gender" value="M" v-model="user.gender" />
            <label for="gender">Женский </label>
            <input type="radio" name="gender" value="W" v-model="user.gender" />
        </div>
        <label for="password">Пароль:</label>
        <input type="password" name="password" v-model="user.password" />
        <label for="confirm-password">Подвердите пароль:</label>
        <input
            type="password"
            name="confirm-password"
            v-model="user.passwordConfirm"
        />
        <input
            type="button"
            value="Зарегистрироваться"
            v-bind:disabled="
                !(
                    user.password !== '' &&
                    user.password === user.passwordConfirm
                )
            "
            v-on:click="printInformation()"
        />
    </form>
    <p>
        Пользователь: {{ user.name }} {{ user.surname }}
        {{
            user.gender === "M"
                ? "мужского пола"
                : user.gender === "W"
                ? "женского пола"
                : ""
        }}
    </p>
</template>

<script setup>
import { reactive } from "vue";

let user = reactive({
    name: "",
    surname: "",
    gender: "",
    password: "",
    passwordConfirm: "",
});

function printInformation() {
    for (let key in user) {
        console.log(key, user[key]);
    }
}
</script>

<style scoped>
.form-container {
    display: flex;
    flex-direction: column;
    width: 200px;
    gap: 5px;
}

.gender {
    display: flex;
    gap: 5px;
    align-items: center;
}
</style>
