import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_app/core/utils/app_color.dart';
import 'package:video_player/video_player.dart';

class NowPlayingVideoWidget extends StatefulWidget {
  final String url;
  final double height;

  const NowPlayingVideoWidget({
    Key? key,
    required this.url,
    required this.height,
  }) : super(key: key);

  @override
  State<NowPlayingVideoWidget> createState() => _NowPlayingVideoWidgetState();
}

class _NowPlayingVideoWidgetState extends State<NowPlayingVideoWidget> {
  VideoPlayerController? videoPlayerController;

  late ChewieController chewieController;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    final fileInfo = await checkCacheFor(widget.url);
    if (fileInfo == null) {
      videoPlayerController = VideoPlayerController.network(widget.url)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize().then((value) {
        cachedForUrl(widget.url);
      });
    } else {
      final file = fileInfo.file;
      videoPlayerController = VideoPlayerController.file(file)
        ..addListener(() => setState(() {}));
      await videoPlayerController!.initialize();
    }
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
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
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height.h,
      width: double.infinity,
      child: (videoPlayerController == null)
          ? Center(
              child: Shimmer.fromColors(
              baseColor: AppColors.myLightGrey,
              highlightColor: AppColors.myGrey,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ))
          : videoPlayerController!.value.isInitialized
              ? AspectRatio(
                  aspectRatio: videoPlayerController!.value.size.width /
                      videoPlayerController!.value.size.height,
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

Future<FileInfo?> checkCacheFor(String url) async {
  final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
  return value;
}

void cachedForUrl(String url) async {
  await DefaultCacheManager().getSingleFile(url).then((value) {});
}
