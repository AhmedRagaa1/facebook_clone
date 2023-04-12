import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:video_player/video_player.dart';

class NowPlayingVideoPreviewWidget extends StatefulWidget {
  final File? url;
  final double height;

  const NowPlayingVideoPreviewWidget({
    Key? key,
    required this.url,
    required this.height,
  }) : super(key: key);

  @override
  State<NowPlayingVideoPreviewWidget> createState() => _NowPlayingVideoPreviewWidgetState();
}

class _NowPlayingVideoPreviewWidgetState extends State<NowPlayingVideoPreviewWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    videoPlayerController = VideoPlayerController.file(widget.url!)
      ..addListener(() => setState(() {}));
    await videoPlayerController.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      materialProgressColors:
          ChewieProgressColors(playedColor: AppColors.myBlue),
      errorBuilder: (context, message) {
        return Center(
          child: Text(message),
        );
      },
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height.h,
      width: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.size.width /
                  videoPlayerController.value.size.height,
              child: Container(
                color: Colors.black,
                child: Chewie(
                  controller: chewieController,
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
