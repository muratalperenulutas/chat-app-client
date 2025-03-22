import 'package:chat_app/constants/shared_pref_key.dart';
import 'package:chat_app/features/auth/services/auth.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/register_progress.dart';

class AuthController extends GetxController {
  final myId = ''.obs;
  var accessToken = ''.obs;
  var refreshToken = ''.obs;
  var isLoggedIn = false.obs;
  var isLoading = true.obs;

  Rx<RegisterProgress> registerProgress=RegisterProgress.INITIAL.obs;

  @override
  void onInit() {
    super.onInit();
     _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    myId.value = prefs.getString(SharedPrefKey.userIdKey) ?? '';
    accessToken.value = prefs.getString(SharedPrefKey.accessTokenKey) ?? '';
    refreshToken.value = prefs.getString(SharedPrefKey.refreshTokenKey) ?? '';
    isLoggedIn.value = refreshToken.value.isNotEmpty;
    isLoading.value = false;
  }

  void setUserId(String value) async {
    myId.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKey.userIdKey, value);
  }

  void setAccessToken(String value) async {
    accessToken.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKey.accessTokenKey, value);
  }

  void setRefreshToken(String value) async {
    refreshToken.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPrefKey.refreshTokenKey, value);
  }
  void setLoggedIn(){
    isLoggedIn.value = true;
  }

  void logout() async {
    setRefreshToken('');
    setAccessToken('');
    isLoggedIn.value = false;
  }

  void setRegisterProgress(RegisterProgress progress){
    registerProgress.value=progress;
  }

  Future<String> getAccessToken()  async {
    Duration remainingTime = JwtDecoder.getRemainingTime(accessToken.value);
    print("Remained access token time: $remainingTime");
    if(remainingTime > Duration(minutes: 5)){
      return accessToken.value;
    }else if(remainingTime > Duration(minutes: 1)&&remainingTime < Duration(minutes: 5)){
      AuthService.refresh();
      return accessToken.value;
    }
    for(int i=1;i<4;i++){
       if(JwtDecoder.getRemainingTime(accessToken.value) < Duration(minutes: 1)){
         print("Refreshing access token... Attempt #$i");
         await AuthService.refresh();
       }else{
         return accessToken.value;
       }
    }
    return '';
  }
}
