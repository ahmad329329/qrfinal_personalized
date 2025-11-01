
import 'package:qrfinal_personalized/res/ap_url/app_url.dart';

import '../../data/network/Network_Api_Services.dart';

class HomeRepository{

  final _apiServices= NetworkApiServices();

  Future <dynamic> homeapi(var data) async{
    dynamic response = _apiServices.postapi(data, AppUrl.homeApi);
    return response;
  }
}