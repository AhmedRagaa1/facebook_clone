import 'package:social_app/features/chat/domain/entites/messanger.dart';
import 'package:social_app/features/chat/domain/usescase/send_message_use_case.dart';

abstract class ChatBaseRepository
{
  Future sendMessage(SendMessageParameters sendMessageParameters);

}