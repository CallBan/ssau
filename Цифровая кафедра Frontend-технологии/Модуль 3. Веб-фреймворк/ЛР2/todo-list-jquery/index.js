const tasks = [];

function addTask() {
  const newTask = $("#new-task").val();
  if (newTask.trim() !== "") {
    tasks.push({ text: newTask, completed: false });
    const listItem = $('<li class="todo-item"></li>');
    const taskText = $("<span></span>").text(newTask);
    $(listItem).append(taskText);

    const buttons = $("<div></div>", { class: "buttons-container" });
    $(listItem).append(buttons);

    const editButton = $("<button>✏</button>");
    $(editButton).on("click", function (e) {
      e.stopPropagation();
      const text = prompt("Введите задачу");
      $(taskText).text(text);
    });
    $(buttons).append(editButton);

    const deleteButton = $("<button>❌</button>");
    $(deleteButton).on("click", function () {
      $(listItem).remove();
    });
    $(buttons).append(deleteButton);

    $(listItem).on("click", function () {
      const index = $(this).index();
      tasks[index].completed = !tasks[index].completed;
      $(taskText).toggleClass("completed");
    });

    $("#todo-list").append(listItem);
    $("#new-task").val("");
  }
}

$("form").on("submit", function (e) {
  e.preventDefault();
  addTask();
});
