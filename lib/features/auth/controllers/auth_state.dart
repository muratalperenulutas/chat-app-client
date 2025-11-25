import 'package:chat_app/features/auth/models/register_progress.dart';

class AuthState {
  final String myId;
  final String accessToken;
  final String refreshToken;
  final bool isLoggedIn;
  final bool isLoading;
  final RegisterProgress registerProgress;

  AuthState({
    this.myId = '',
    this.accessToken = '',
    this.refreshToken = '',
    this.isLoggedIn = false,
    this.isLoading = true,
    this.registerProgress = RegisterProgress.initial,
  });

  AuthState copyWith({
    String? myId,
    String? accessToken,
    String? refreshToken,
    bool? isLoggedIn,
    bool? isLoading,
    RegisterProgress? registerProgress,
  }) {
    return AuthState(
      myId: myId ?? this.myId,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      registerProgress: registerProgress ?? this.registerProgress,
    );
  }
}
