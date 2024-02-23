class Task {
  Task({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  late final String id;
  late final String createdAt;
  late final String updatedAt;
  late final String title;
  late final String description;
  late final bool isCompleted;

  Task.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['is_completed'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['title'] = title;
    data['description'] = description;
    data['is_completed'] = isCompleted;
    return data;
  }
}
