class Todo {
  final String todoId;
  String todoTitle;
  String todoDescription;
  final String todoCreatedDate;
  bool isDone;

  Todo({
    required this.todoId,
    required this.todoTitle,
    required this.todoDescription,
    required this.todoCreatedDate,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todoId: json['id'] as String? ?? "",
      todoTitle: json['title'] as String? ?? "",
      todoDescription: json['description'] as String? ?? "",
      todoCreatedDate: json['createdDate'] as String? ?? "",
      //isDone: json["isDone"] as bool? ?? false,
      isDone: json['isDone'] == 'true' || json['isDone'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': todoId,
      'title': todoTitle,
      'description': todoDescription,
      'createdDate': todoCreatedDate,
      'isDone': isDone,
    };
  }
}