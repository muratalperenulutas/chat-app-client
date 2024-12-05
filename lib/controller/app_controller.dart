import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController{
  final userId=0.obs;
  var accessToken=''.obs;
  var refreshToken=''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    userId.value = prefs.getInt('userId') ?? 0;
    accessToken.value=prefs.getString('accessToken')??'';
    refreshToken.value=prefs.getString('refreshToken')??'';
  }

  void setUserId(int value) async {
    userId.value=value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', value);
  }
  void setAccessToken(String value) async {
    accessToken.value=value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', value);
  }
  void setRefreshToken(String value) async {
    refreshToken.value=value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', value);
  }
}



