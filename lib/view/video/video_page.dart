import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Are you sure you want to leave this page?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    Rx<VideoPlayerController> videoPlayerController =
        VideoPlayerController.networkUrl(
      Uri.parse(
        homeController.apiModel!.categories[homeController.selectIndex.value]
            .videos[homeController.selectIndexVideo.value].sources[0]
            .toString()
            .split("http")
            .join("https"),
      ),
    ).obs;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          videoPlayerController.value.pause();
          Get.back();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                centerTitle: true,
                title: Text("Video Player"),
                leading: IconButton(
                    onPressed: () {
                      videoPlayerController.value.pause();
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
              ),
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Obx(
                  () => Chewie(
                    controller: ChewieController(
                      videoPlayerController: videoPlayerController.value,
                      autoPlay: true,
                      allowFullScreen: true,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(CupertinoIcons.videocam_fill),
                title: Text(homeController
                    .apiModel!
                    .categories[homeController.selectIndex.value]
                    .videos[homeController.selectIndexVideo.value]
                    .title),
                subtitle: Text(homeController
                    .apiModel!
                    .categories[homeController.selectIndex.value]
                    .videos[homeController.selectIndexVideo.value]
                    .subtitle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        homeController
                            .apiModel!
                            .categories[
                        homeController.selectIndex.value]
                            .videos[homeController
                            .selectIndexVideo.value]
                            .description,
                      ),
                    ),
                  ],
                ),
              )
                    // ...List.generate(
                    //   homeController
                    //       .apiModel!
                    //       .categories[homeController.selectIndex.value]
                    //       .videos
                    //       .length,
                    //   (indexVideo) {
                    //     return (homeController.selectIndexVideo.value !=
                    //             indexVideo)
                    //         ? ListTile(
                    //             onTap: () {
                    //               // more info share create function there.
                    //               homeController.selectIndexVideo =
                    //                   indexVideo.obs;
                    //               // homeController.selectIndex = index.obs;
                    //               //todo navigation another page and share video link and more Info that index and more many much there...
                    //               // Get.toNamed("/video");
                    //               setState(() {});
                    //             },
                    //             leading: Container(
                    //               height: 50,
                    //               width: 80,
                    //               decoration: BoxDecoration(
                    //                 image: DecorationImage(
                    //                     image: NetworkImage(homeController
                    //                         .apiModel!
                    //                         .categories[homeController
                    //                             .selectIndex.value]
                    //                         .videos[indexVideo]
                    //                         .thumb),
                    //                     fit: BoxFit.cover),
                    //               ),
                    //             ),
                    //             title: Text(homeController
                    //                 .apiModel!
                    //                 .categories[
                    //                     homeController.selectIndex.value]
                    //                 .videos[indexVideo]
                    //                 .title),
                    //             subtitle: Text(homeController
                    //                 .apiModel!
                    //                 .categories[
                    //                     homeController.selectIndex.value]
                    //                 .videos[indexVideo]
                    //                 .subtitle),
                    //           )
                    //         : Container();
                    //   },
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
