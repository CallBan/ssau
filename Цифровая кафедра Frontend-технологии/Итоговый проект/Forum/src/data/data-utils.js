import { topics } from "./data";

export function getDiscussionId() {
  let id = 1;
  for (let topic of topics) {
    id += topic.discussions.length;
  }
  return id;
}

export function getCurrentDate() {
  let currentDate = new Date();
  let year = currentDate.getFullYear();
  let month = currentDate.getMonth() + 1;
  let day = currentDate.getDate();
  month = month < 10 ? "0" + month : month;
  day = day < 10 ? "0" + day : day;
  return year + "-" + month + "-" + day;
}
