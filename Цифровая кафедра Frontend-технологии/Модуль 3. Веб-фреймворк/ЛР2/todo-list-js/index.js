const tasks = [];

function addTask() {
  const newTask = document.getElementById("new-task").value;
  if (newTask.trim() !== "") {
    tasks.push({ task: newTask, completed: false });
    const taskIndex = tasks.length - 1;

    const listItem = document.createElement("li");
    listItem.className = "todo-item";
    const taskNameElement = document.createElement("span");
    taskNameElement.innerText = newTask;
    listItem.appendChild(taskNameElement);

    const buttons = document.createElement("div");
    buttons.className = "buttons-container";
    listItem.appendChild(buttons);

    const editButton = document.createElement("button");
    editButton.innerText = "✏ ";
    editButton.addEventListener("click", (e) => {
      e.stopPropagation();
      const text = prompt("Введите задачу");
      taskNameElement.innerText = text;
    });
    buttons.appendChild(editButton);

    const deleteButton = document.createElement("button");
    deleteButton.innerText = "❌";
    deleteButton.addEventListener("click", function () {
      listItem.parentNode.removeChild(listItem);
    });
    buttons.appendChild(deleteButton);

    listItem.addEventListener("click", function () {
      tasks[taskIndex].completed = !tasks[taskIndex].completed;
      taskNameElement.classList.toggle("completed");
    });

    document.getElementById("todo-list").appendChild(listItem);
    document.getElementById("new-task").value = "";
  }
}

document.getElementById("add-button").onclick = addTask;
