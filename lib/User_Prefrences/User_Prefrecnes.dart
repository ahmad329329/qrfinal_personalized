
import 'package:qrfinal_personalized/Models/User_model/User_Model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefrences{

  Future<bool> saveUser(UserModel responseModel) async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    sp.setString("id", responseModel.id.toString());
    return true;
  }


  Future<UserModel> getUser() async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    String? id = sp.getString("id");
    return UserModel(id);
  }

  Future<bool> removeUser() async{
    SharedPreferences sp =await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }

  }
