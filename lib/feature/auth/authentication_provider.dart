import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_firebase/product/enums/cache_items.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationProvider extends StateNotifier<AuthState> {
  AuthenticationProvider() : super(const AuthState());

  Future<void> fetchUserDetail(User? user) async {
    if (user == null) return;
    final token = await user.getIdToken();
    await saveTokenToCache(token);
    state = state.copyWith(isRedirect: true);
  }

  Future<void> saveTokenToCache(String token) async {
    await CacheItems.token.write(token);
  }
}

class AuthState extends Equatable {
  const AuthState({this.isRedirect = false});

  final bool isRedirect;

  @override
  List<Object> get props => [isRedirect];

  AuthState copyWith({
    bool? isRedirect,
  }) {
    return AuthState(
      isRedirect: isRedirect ?? this.isRedirect,
    );
  }
}
