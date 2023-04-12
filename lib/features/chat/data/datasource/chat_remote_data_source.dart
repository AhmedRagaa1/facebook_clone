import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/chat/data/model/message_model.dart';
import 'package:social_app/features/chat/domain/usescase/send_message_use_case.dart';

abstract class ChatBaseRemoteDataSource {
  Future sendMessage(SendMessageParameters sendMessageParameters);
}

class ChatRemoteDataSource extends ChatBaseRemoteDataSource {
  @override
  Future sendMessage(SendMessageParameters sendMessageParameters) async {
    MessageModel model = MessageModel(
        senderId: sendMessageParameters.senderId,
        receiverId: sendMessageParameters.receiverId,
        message: sendMessageParameters.message,
        timeCreating: sendMessageParameters.timeCreating,
        messageImage: sendMessageParameters.postImage,
        messageVideo: sendMessageParameters.postVideo,
        voiceMessage: sendMessageParameters.voiceMessage,
    );
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(sendMessageParameters.receiverId)
          .collection('messages')
          .add(model.toMap());

      FirebaseFirestore.instance
          .collection('users')
          .doc(sendMessageParameters.receiverId)
          .collection('chats')
          .doc(uId)
          .collection('messages')
          .add(model.toMap());
    } catch (error)
    {
      rethrow;
    }
  }




}
