
import 'package:get/get.dart';

import '../model/api_model.dart';
import '../services/api_helper.dart';

class HomeController extends GetxController
{
  ApiModel? apiModel;
  RxInt selectIndex = 0.obs;
  RxInt selectIndexVideo = 0.obs;
  HomeController()
  {
    apiCalling();
  }

  Future<ApiModel?> apiCalling()
  async {
    final jsonMap = await ApiHelper.apiHelper.apiResponse();
    apiModel = ApiModel.fromJson(jsonMap);
    return apiModel;
  }
}