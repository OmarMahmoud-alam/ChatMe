import 'package:hive/hive.dart';



part 'notemodule.g.dart';
@HiveType(typeId: 0)
class NodeModule extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  int color;

  NodeModule({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'color': color,
    };
  }

  factory NodeModule.fromMap(Map<String, dynamic> map) {
    return NodeModule(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      color: map['color'],
    );
  }
}
