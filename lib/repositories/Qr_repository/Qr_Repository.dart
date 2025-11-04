

import 'package:qrfinal_personalized/res/ap_url/app_url.dart';

import '../../data/network/Network_Api_Services.dart';

class QrRepository{

  final _apiServices= NetworkApiServices();

  Future <dynamic> qrapi(var data) async{
    dynamic response = _apiServices.postapi(data, AppUrl.scanqr);
    return response;
  }
}