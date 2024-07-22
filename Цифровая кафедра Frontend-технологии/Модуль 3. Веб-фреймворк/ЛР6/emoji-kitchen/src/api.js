export async function loadCharacters(search = '') {
    const response = await fetch(`https://api.potterdb.com/v1/characters?page[size]=100&filter[name_cont]=${search}`);

    if (!response.ok) {
        throw new Error('Ошибка загрузки персонажей...')
    }

    const { data } = await response.json();

    return data;
}