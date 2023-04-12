import 'package:social_app/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:social_app/features/chat/domain/baserepository/chat_base_repository.dart';
import 'package:social_app/features/chat/domain/entites/messanger.dart';
import 'package:social_app/features/chat/domain/usescase/send_message_use_case.dart';

class ChatRepository extends ChatBaseRepository
{
  final ChatBaseRemoteDataSource chatBaseRemoteDataSource;

  ChatRepository(this.chatBaseRemoteDataSource);

  @override
  Future sendMessage(SendMessageParameters sendMessageParameters) async
  {
   try{
     await chatBaseRemoteDataSource.sendMessage(sendMessageParameters);
   }catch(error)
   {
     rethrow;
   }
  }



}