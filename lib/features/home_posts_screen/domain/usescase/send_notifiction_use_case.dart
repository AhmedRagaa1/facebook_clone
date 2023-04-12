import 'package:equatable/equatable.dart';
import 'package:social_app/core/base_use_case/base_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';

class SendNotificationUseCase extends BaseUseCase<void , SendNotificationParameters>
{
  final HomeBaseRepository homeBaseRepository;

  SendNotificationUseCase(this.homeBaseRepository);

  @override
  Future<void> call(SendNotificationParameters parameters) async
  {
    return await homeBaseRepository.sendNotification(parameters);
  }
}

class SendNotificationParameters extends Equatable
{
  final String title;
  final String body;
  final String deviceToken;

  const SendNotificationParameters({required this.title, required this.body, required this.deviceToken});

  @override
  List<Object?> get props =>
      [
        title,
        body,
        deviceToken,
      ];
}