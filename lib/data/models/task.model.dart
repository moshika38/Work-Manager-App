class TaskModel {
  final String id;
  final String title;
  final String dueDate;
  final bool isCompleted;


  TaskModel({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      dueDate: json['dueDate'],
      isCompleted: json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'dueDate': dueDate,
      'isCompleted': isCompleted,
    };
  }
}
