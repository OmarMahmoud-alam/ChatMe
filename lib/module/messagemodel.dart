class MassageModel {
  late String senduid;
  late String receiveid;
  late String text;
  late int datetime;
  late String type;

  MassageModel({
    required this.senduid,
    required this.receiveid,
    required this.text,
    required this.datetime,
    required this.type,
  });

  MassageModel.fromJson(Map<String, dynamic>? json) {
    senduid = json!['senduid'];
    receiveid = json['receiveid'];
    text = json['text'];
    datetime = json['datetime'];
    type = json['type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senduid': senduid,
      'receiveid': receiveid,
      'text': text,
      'datetime': datetime,
      'type': type,
    };
  }
}
