import 'package:social_app/features/chat/domain/entites/messanger.dart';

class MessageModel extends Message {
  MessageModel(
      {
      required super.senderId,
      required super.receiverId,
      required super.message,
      required super.timeCreating,
      required  super.messageImage,
      required  super.messageVideo,
      required  super.voiceMessage,
      });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        senderId: json['senderId'],
        receiverId: json['receiverId'],
        message: json['message'],
        timeCreating: json['timeCreating'],
    messageImage: json['messageImage'],
    messageVideo: json['messageVideo'],
    voiceMessage: json['voiceMessage'],
      );

  Map<String , dynamic> toMap()
  {
    return
      {

        'timeCreating':timeCreating,
        'messageImage': messageImage ,
        'messageVideo': messageVideo ,
        'message':message,
        'senderId':senderId,
        'receiverId':receiverId,
        'voiceMessage':voiceMessage,


      };
  }
}
