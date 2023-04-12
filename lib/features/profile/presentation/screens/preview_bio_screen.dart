import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/constant.dart';
import 'package:social_app/features/profile/presentation/screens/edit_profile_screen.dart';

import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/utils/component.dart';
import '../controller/profile_cubit.dart';

class EditBio extends StatelessWidget {
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  EditBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getUserData(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdateBioSuccessState) {
            navigateTo(context, EditProfileScreen());
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    const Text(
                      AppString.editBio,
                    ),
                    SizedBox(
                      width: 190.w,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: defaultMaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateBio(bio: bioController.text);
                          }
                        },
                        text: AppString.save,
                        height: 63.h,
                        width: 75.w,
                        background: AppColors.myBlue,
                        textColor: AppColors.myWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0).r,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            backgroundImage: NetworkImage(
                                cubit.socialDataUser.image.toString()),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.socialDataUser.firstName.toString() +
                                    cubit.socialDataUser.surName.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .apply(fontSizeFactor: 1.3.sp),
                              ),
                              SizedBox(
                                height: 7.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Theme(
                                      data: ThemeData(
                                        iconTheme: IconThemeData(
                                          color: AppColors.myGrey,
                                          size: 22.r,
                                        ),
                                      ),
                                      child: const Icon(Icons.public_outlined)),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    AppString.public,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.apply(fontSizeFactor: 1.2.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      defaultTextFormField(
                        controller: bioController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your new bio';
                          }
                        },
                        type: TextInputType.text,
                        maxLines: 7,
                        hint: AppString.previewBioText,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
