class Task {
  int? id;
  String title;
  String description;
  String status;

  Task({this.id, required this.title, required this.description, required this.status});

  factory Task.fromMap(Map<String, dynamic> json) => new Task(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    status: json['status'],
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'title': title,
      'description': description,
      'status': status,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
