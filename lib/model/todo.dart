class Todo {
  int id;
  int category;
  String todoName;
  String todoMemo;
  bool complete;
//  String createDt;
//  String updateDt;
//  String scheduleStart;
//  String scheduleEnd;

  Todo({
    this.id,
    this.category,
    this.todoName,
    this.todoMemo,
    this.complete,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => new Todo(
        id: json["id"],
        category: json["category"],
        todoName: json["todoName"],
        todoMemo: json["todoMemo"],
        complete: json["complete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "todoName": todoName,
        "todoMemo": todoMemo,
        "complete": complete,
      };
}
