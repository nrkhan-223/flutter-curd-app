class CreateTask {
  CreateTask({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
  late final String title;
  late final String description;
  late final bool isCompleted;

  CreateTask.fromJson(Map<String, dynamic> json){
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    return data;
  }
}