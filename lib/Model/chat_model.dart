class ChatModel {
  String name;
  String icon;
  bool? isGroup;
  String? time;
  String? currentMessage;

  ChatModel({
    required this.name,
    required this.icon,
    this.isGroup,
    this.time,
    this.currentMessage,
  });
}
