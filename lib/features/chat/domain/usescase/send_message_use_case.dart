import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/chat/domain/baserepository/chat_base_repository.dart';

class SendMessageUseCase extends BaseUseCase<void , SendMessageParameters>
{
  final ChatBaseRepository chatBaseRepository;

  SendMessageUseCase(this.chatBaseRepository);
  @override
  Future<void> call(SendMessageParameters parameters)async {
    return await chatBaseRepository.sendMessage(parameters);
  }

}

class SendMessageParameters extends Equatable {
  final String senderId;
  final String receiverId;
  final String timeCreating;
  final String? message;
  final String? postImage;
  final String? postVideo;
  final String? voiceMessage;


  const SendMessageParameters({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeCreating,
    this.postImage,
    this.postVideo,
    this.voiceMessage,
  });

  @override
  List<Object?> get props =>
      [
        timeCreating,
        postImage,
        postVideo,
        receiverId,
        voiceMessage,
      ];
}