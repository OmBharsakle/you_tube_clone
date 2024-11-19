import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/home_controller.dart';
import '../../model/api_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: const Text("Video Player"),
            ),
            FutureBuilder(
              future: homeController.apiCalling(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.hasData) {
                  ApiModel? apiModel = snapshot.data;
                  return Column(
                    children: [
                      ...List.generate(
                        apiModel!.categories.length,
                        (index) => Column(
                          children: [
                            ...List.generate(
                              apiModel.categories[index].videos.length,
                              (indexVideo) {
                                return GestureDetector(
                                  onTap: () {
                                    homeController.selectIndexVideo = indexVideo.obs;
                                    homeController.selectIndex = index.obs;
                                    //todo navigation another page and share video link and more Info that index and more many much there...
                                    Get.toNamed("/video");
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Container(
                                          height: 230,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(apiModel
                                                    .categories[index]
                                                    .videos[indexVideo]
                                                    .thumb),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(apiModel.categories[index]
                                            .videos[indexVideo].title),
                                        subtitle: Text(apiModel.categories[index].videos[indexVideo].subtitle),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// https://raw.githubusercontent.com/bikashthapa01/myvideos-android-app/master/data.json
