

import '../../data/network/Network_Api_Services.dart';
import '../../res/ap_url/app_url.dart';

class SignupRepository{

  final _apiServices= NetworkApiServices();

  Future <dynamic> Signupapi(var data) async{
    dynamic response = _apiServices.postapi(data, AppUrl.signupApi);
    return response;
  }
}