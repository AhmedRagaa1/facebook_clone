import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:social_app/features/home_posts_screen/presentation/controller/home_cubit.dart';

import '../../../../core/services/services_locator.dart';

class ViewStoryScreen extends StatefulWidget {
  ViewStoryScreen({Key? key, required this.storyImage , required this.imageOfPublisher , required this.nameOfPublisher}) : super(key: key);
  final String storyImage;
  final String imageOfPublisher;
  final String nameOfPublisher;

  @override
  State<ViewStoryScreen> createState() => _ViewStoryScreenState();
}

class _ViewStoryScreenState extends State<ViewStoryScreen> {
  double percent = 0;
  Timer? timer;
  void startTimer()
  {
    timer = Timer.periodic(const Duration(milliseconds: 3), (timer)
    {
      setState(() {
        percent += 0.001;
        if(percent > 1)
        {
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>(),
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              CachedNetworkImage
                (
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                imageUrl: widget.storyImage.toString(),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.myLightGrey,
                  highlightColor: AppColors.myGrey,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.myBlack,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                errorWidget: (context, url ,error) => const Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8).r,
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: percent,
                      color: AppColors.myGrey,
                      backgroundColor: AppColors.myLightGrey,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return Positioned(
                    top: 60.h,
                    left: 20.h,
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60.0.w,
                            height: 60.0.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          imageUrl: widget.imageOfPublisher.toString(),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.myLightGrey,
                            highlightColor: AppColors.myGrey,
                            child: Container(
                              width: 60.0.w,
                              height: 60.0.h,
                              decoration: BoxDecoration(
                                color: AppColors.myBlack,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          widget.nameOfPublisher,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(fontSizeFactor: 1.3.sp),
                        ),

                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
