class Mark {
  constructor(subject, mark) {
    this.subject = subject;
    this.mark = mark;
  }
}

class Student {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.marks = [];
  }

  getAvarageMark() {
    let sum = 0;
    if (this.marks.length == 0) {
      return 0;
    }
    for (let i = 0; i < this.marks.length; i++) {
      sum += this.marks[i].mark;
    }
    return sum / this.marks.length;
  }

  getMarksBySubject(subject) {
    let marksBySubject = [];
    for (let i = 0; i < this.marks.length; i++) {
      if (this.marks[i].subject == subject) {
        marksBySubject.push(this.marks[i].mark);
      }
    }
    return marksBySubject;
  }

  addMark(subject, mark) {
    let newMark = new Mark(subject, mark);
    this.marks.push(newMark);
  }

  removeMarksBySubject(subject) {
    this.marks = this.marks.filter((mark) => mark.subject != subject);
  }
}

let student1 = new Student("Ivanov", "Ivan");

student1.addMark("math", 5);
student1.addMark("math", 4);
student1.addMark("math", 5);
student1.addMark("fisics", 4);
student1.addMark("fisics", 5);
student1.addMark("fisics", 4);

console.log(student1.getMarksBySubject("math"));
console.log(student1.getAvarageMark());

student1.removeMarksBySubject("math");

console.log(JSON.stringify(student1));
