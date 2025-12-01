import 'dart:convert';
import 'dart:io';

import 'package:chat_app/constants/shared_pref_key.dart';
import 'package:chat_app/core/di/injection.dart';
import 'package:chat_app/core/services/api/api.dart';
import 'package:chat_app/features/auth/controllers/auth_state.dart';
import 'package:chat_app/features/auth/models/login.dart';
import 'package:chat_app/features/auth/models/register.dart';
import 'package:chat_app/features/auth/models/register_progress.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/database_service.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    _loadPreferences();
    return AuthState();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final myId = prefs.getString(SharedPrefKey.userIdKey) ?? '';
    final accessToken = prefs.getString(SharedPrefKey.accessTokenKey) ?? '';
    final refreshToken = prefs.getString(SharedPrefKey.refreshTokenKey) ?? '';
    final isLoggedIn = refreshToken.isNotEmpty;

    if (isLoggedIn && myId.isNotEmpty) {
      getIt<DatabaseService>().init(userId: myId);
    }
    
    state = state.copyWith(
      myId: myId,
      accessToken: accessToken,
      refreshToken: refreshToken,
      isLoggedIn: isLoggedIn,
      isLoading: false,
    );
  }

  void setUserId(String value) {
    state = state.copyWith(myId: value);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(SharedPrefKey.userIdKey, value);
    });
  }

  void setAccessToken(String value) {
    state = state.copyWith(accessToken: value);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(SharedPrefKey.accessTokenKey, value);
    });
  }

  void setRefreshToken(String value) {
    state = state.copyWith(refreshToken: value);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString(SharedPrefKey.refreshTokenKey, value);
    });
  }

  void setLoggedIn() {
    state = state.copyWith(isLoggedIn: true);
  }

  void logout() async {
    setRefreshToken('');
    setAccessToken('');
    state = state.copyWith(isLoggedIn: false);
    await getIt<DatabaseService>().closeDatabase();
  }

  void setRegisterProgress(RegisterProgress progress) {
    state = state.copyWith(registerProgress: progress);
  }

  Future<void> login(Login login, {required Function(String) onError, required Function() onSuccess}) async {
    debugPrint("Login");
    try {
      final response = await Api.postLoginRequest(login);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];

      if (response.statusCode == 200) {
        String accessToken = jsonResponse['accessToken'];
        String refreshToken = jsonResponse['refreshToken'];

        if (JwtDecoder.isExpired(refreshToken) ||
            JwtDecoder.isExpired(accessToken)) {
          debugPrint('Token expired');
          onError('Token expired');
        } else {
          setAccessToken(accessToken);
          setRefreshToken(refreshToken);
          setLoggedIn();
          
          Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
          debugPrint('Decoded Token: $decodedToken');
          String userId = decodedToken["sub"];
          setUserId(userId);

          await getIt<DatabaseService>().init(userId: userId);
          
          onSuccess();
        }
      } else {
        onError(message);
      }
    } on SocketException catch (e2) {
      debugPrint(e2.toString());
      onError('No internet connection');
    } catch (e) {
      debugPrint('Error: $e');
      onError('An error occurred');
    }
  }

  Future<void> register(Register register, {required Function(String) onError, required Function(String) onSuccess}) async {
    debugPrint ("Register");
    try {
      final response = await Api.postRegisterRequest(register);
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String message = jsonResponse['message'];
      debugPrint(jsonResponse.toString());
      if (response.statusCode == 201) {
        setRegisterProgress(RegisterProgress.email);
        onSuccess(message);
      } else {
        onError(message);
      }
    } on SocketException catch (e2) {
      debugPrint(e2.toString());
      onError('No internet connection');
    } catch (e) {
      debugPrint('Error: $e');
      onError('An error occurred');
    }
  }

  Future<void> refresh() async {
    debugPrint("Refresh");
    try {
      final response = await Api.postRefreshRequest(state.refreshToken);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        debugPrint(jsonResponse['message']);
        setAccessToken(jsonResponse['accessToken']);
      } else if (response.statusCode == 401) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        String message = jsonResponse['message'];
        debugPrint(message);
        logout();
      } else {
        debugPrint('Refresh failed: ${response.body}');
      }
    } on SocketException catch (e2) {
      debugPrint('No internet connection');
      debugPrint(e2.toString());
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<String> getAccessToken() async {
    if (state.accessToken.isEmpty) {
      return '';
    }
    Duration remainingTime = JwtDecoder.getRemainingTime(state.accessToken);
    debugPrint("Remained access token time: $remainingTime");
    if (remainingTime > Duration(minutes: 5)) {
      return state.accessToken;
    } else if (remainingTime > Duration(minutes: 1) && remainingTime < Duration(minutes: 5)) {
      await refresh();
      return state.accessToken;
    }
    for (int i = 1; i < 4; i++) {
      if (JwtDecoder.getRemainingTime(state.accessToken) < Duration(minutes: 1)) {
        debugPrint("Refreshing access token... Attempt #$i");
        await refresh();
      } else {
        return state.accessToken;
      }
    }
    return '';
  }
}
