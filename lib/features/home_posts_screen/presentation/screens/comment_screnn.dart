import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:social_app/core/utils/component.dart';
import 'package:social_app/features/home_posts_screen/presentation/components/comment_item.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';
import '../../../../core/services/services_locator.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/app_string.dart';

class CommentScreen extends StatelessWidget {
  final String postId;
  final String deviceToken;
  final String userId;

  CommentScreen({Key? key, required this.postId , required this.deviceToken , required this.userId}) : super(key: key);

  var commentController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()
        ..getUserData()
        ..getComment(postId: postId),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text(
                AppString.comment,
              ),
            ],
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  var cubit = HomeCubit.get(context);
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildCommentItem(cubit, index, context),
                      separatorBuilder: (context, index) => Container(
                        height: 10.h,
                      ),
                      itemCount: cubit.comments.length,
                    ),
                  );
                },
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 70.h,
                width: double.infinity,
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 0).r,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: defaultTextFormField(
                          controller: commentController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' please comment must not be empty';
                            }
                          },
                          hint: 'write your comment.....🙄',
                          borderRadius: BorderRadius.circular(25.r),
                          borderColor: AppColors.myBlue,
                          hintColor: AppColors.myBlack,
                          maxLines: null,
                          expands: true,
                          minLines: null,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    BlocConsumer<HomeCubit, HomeState>(
                      listener: (context, state) {
                        if (state is AddCommentSuccessState) {
                          HomeCubit.get(context).getComment(postId: postId);
                        }
                      },
                      builder: (context, state) {
                        return InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                var now = DateTime.now();
                                var dateTime = DateFormat.yMMMEd().format(now);
                                HomeCubit.get(context).addComment(
                                    commentLen:
                                        HomeCubit.get(context).comments.length +
                                            1,
                                    comment: commentController.text,
                                    timeCreating: dateTime.toString(),
                                    postId: postId,
                                title: 'Comment on your post',
                                body: '${HomeCubit.get(context).socialDataUser.firstName} ${HomeCubit.get(context).socialDataUser.surName} comment on your post',
                                deviceToken: deviceToken,
                                  uId: userId,
                                );
                                commentController.clear();
                              }
                            },
                            child: Icon(
                              Icons.send,
                              size: 34.r,
                            ));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
