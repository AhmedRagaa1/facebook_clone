import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String timeCreating;
  final String? message;
  final String? messageImage;
  final String? messageVideo;
  final String? voiceMessage;


  const Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeCreating,
    this.messageImage,
    this.messageVideo,
    this.voiceMessage,
  });

  @override
  List<Object?> get props =>
      [
        timeCreating,
        messageImage,
        messageVideo,
        receiverId,
        senderId,
        message,
        voiceMessage,
      ];
}
