import 'package:get_it/get_it.dart';
import 'package:social_app/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:social_app/features/authentication/data/repository/auth.dart';
import 'package:social_app/features/authentication/domain/baserepository/auth.dart';
import 'package:social_app/features/authentication/domain/usescase/create_user.dart';
import 'package:social_app/features/authentication/domain/usescase/reset_password.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_in.dart';
import 'package:social_app/features/authentication/domain/usescase/sign_up.dart';
import 'package:social_app/features/authentication/presentation/controller/auth_cubit.dart';
import 'package:social_app/features/chat/data/datasource/chat_remote_data_source.dart';
import 'package:social_app/features/chat/data/repository/chat_repository.dart';
import 'package:social_app/features/chat/domain/baserepository/chat_base_repository.dart';
import 'package:social_app/features/chat/domain/usescase/send_message_use_case.dart';
import 'package:social_app/features/chat/presentation/controller/chat_cubit.dart';
import 'package:social_app/features/home_posts_screen/data/datasource/home_data_source.dart';
import 'package:social_app/features/home_posts_screen/data/repository/home_repository.dart';
import 'package:social_app/features/home_posts_screen/domain/baserepository/home_base_repository.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/add_comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_post_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/create_story_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/get_comment.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/get_stories_use_case.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/like_post.dart';
import 'package:social_app/features/home_posts_screen/domain/usescase/send_notifiction_use_case.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import 'package:social_app/features/profile/data/datasource/base_remote_data_source.dart';
import 'package:social_app/features/profile/data/repository/profile_repository.dart';
import 'package:social_app/features/profile/domain/baserepository/profile_base_repo.dart';
import 'package:social_app/features/profile/domain/usescase/get_user.dart';
import 'package:social_app/features/profile/domain/usescase/update_bio.dart';
import 'package:social_app/features/profile/domain/usescase/update_profile_picture.dart';
import 'package:social_app/features/profile/presentation/controller/profile_cubit.dart';
import '../../features/profile/domain/usescase/update_cover_picture.dart';

final sl= GetIt.instance;
class ServicesLocator
{
  void init()
  {
    //Todo: cubit services locator
    sl.registerFactory(() => AuthCubit(sl(), sl(),sl(),sl()));
    sl.registerFactory(() =>ProfileCubit(sl(),sl(),sl(),sl(),));
    sl.registerFactory(() =>HomeCubit(sl(),sl(), sl(),sl(),sl(), sl(),sl(),sl()));
    sl.registerFactory(() =>ChatCubit(sl(), sl(),sl()));


    //Todo: use Case services locator
    sl.registerLazySingleton(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => CreateUserUseCase(sl()));
    sl.registerLazySingleton(() => SignInUseCase(sl()));
    sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
    sl.registerLazySingleton(() => GetUserDataUseCase(sl()));
    sl.registerLazySingleton(() => UpdateBioUseCase(sl()));
    sl.registerLazySingleton(() => UpdateProfilePictureUseCase(sl()));
    sl.registerLazySingleton(() => UpdateCoverPictureUseCase(sl()));
    sl.registerLazySingleton(() => CreatePostUseCase(sl()));
    sl.registerLazySingleton(() => AddCommentUseCase(sl()));
    sl.registerLazySingleton(() => GetCommentsUseCase(sl()));
    sl.registerLazySingleton(() => LikePostUseCase(sl()));
    sl.registerLazySingleton(() => CreateStoryUseCase(sl()));
    sl.registerLazySingleton(() => GetAllStoriesUseCase(sl()));
    sl.registerLazySingleton(() => SendNotificationUseCase(sl()));
    sl.registerLazySingleton(() => SendMessageUseCase(sl()));



    //Todo: Repository services locator
    sl.registerLazySingleton<AuthBaseRepository>(() => AuthRepository(sl()));
    sl.registerLazySingleton<ProfileBaseRepository>(() => ProfileRepository(sl()));
    sl.registerLazySingleton<HomeBaseRepository>(() => HomeRepository(sl()));
    sl.registerLazySingleton<ChatBaseRepository>(() => ChatRepository(sl()));


    //Todo: Data source services locator
    sl.registerLazySingleton<AuthBaseRemoteDataSource>(() => AuthRemoteDataSource());
    sl.registerLazySingleton<ProfileBaseRemoteDataSource>(() => ProfileRemoteDataSource());
    sl.registerLazySingleton<HomeBaseRemoteDateSource>(() => HomeRemoteDataSource());
    sl.registerLazySingleton<ChatBaseRemoteDataSource>(() => ChatRemoteDataSource());




  }
}