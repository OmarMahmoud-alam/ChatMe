import 'package:hive/hive.dart';

part 'notemodule.g.dart';

@HiveType(typeId: 0)
class NoteModule extends HiveObject {
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  int color;

  NoteModule({
    required this.title,
    required this.content,
    required this.date,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'color': color,
    };
  }

  factory NoteModule.fromMap(Map<String, dynamic> map) {
    return NoteModule(
      title: map['title'],
      content: map['content'],
      date: DateTime.parse(map['date']),
      color: map['color'],
    );
  }
}
