import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/core/utils/images_path.dart';
import 'package:social_app/features/profile/presentation/controller/profile_cubit.dart';
import 'package:social_app/features/profile/presentation/screens/edit_profile_screen.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_string.dart';

class PreviewImageProfileScreen extends StatelessWidget {
  PreviewImageProfileScreen({Key? key, this.profileImage}) : super(key: key);

  var profileImage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                AppString.previewPP,
              ),
              SizedBox(
                width: 35.w,
              ),
              BlocConsumer<ProfileCubit, ProfileState>(
                listener: (context, state) {
                  if(state is UpdateProfilePictureSuccessState)
                  {
                    navigateAndRemove(context, EditProfileScreen());
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: defaultMaterialButton(
                      onPressed: ()
                      {
                        ProfileCubit.get(context).uploadProfileImage(profileImage);
                      },
                      text: AppString.save,
                      height: 63.h,
                      width: 75.w,
                      background: AppColors.myBlue,
                      textColor: AppColors.myWhite,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, bottom: 10).r,
                  child: Row(
                    children: [
                      Text(
                        AppString.to,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Theme(
                          data: ThemeData(
                            iconTheme: IconThemeData(
                              color: AppColors.myGrey,
                            ),
                          ),
                          child: const Icon(Icons.public_outlined)),
                      Text(
                        AppString.public,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.apply(fontSizeFactor: 1.3.sp),
                      ),
                    ],
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 450.h,
                      width: double.infinity,
                      color: AppColors.myBlack,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 195.r,
                        backgroundColor: AppColors.myWhite,
                        child: CircleAvatar(
                          radius: 170.r,
                          backgroundImage: profileImage == null
                              ? const NetworkImage(
                                  ImagesPath.defaultProfileImagePathInFirebase,
                                )
                              : FileImage(profileImage) as ImageProvider,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
