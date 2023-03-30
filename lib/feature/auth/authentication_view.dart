import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebaseui;
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/auth/authentication_provider.dart';
import 'package:flutter_application_firebase/product/constants/string_constants.dart';
import 'package:flutter_application_firebase/product/widget/sub_title_text.dart';
import 'package:flutter_application_firebase/product/widget/title_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider =
      StateNotifierProvider<AuthenticationProvider, AuthState>((ref) {
    return AuthenticationProvider();
  });

  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? currentUser) {
    ref.read(authProvider.notifier).fetchUserDetail(currentUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: firebaseui.FirebaseUIActions(
        actions: [
          firebaseui.AuthStateChangeAction<firebaseui.SignedIn>(
              (context, state) {
            if (state.user != null) {
              checkUser(state.user);
            }
          })
        ],
        child: SafeArea(
          child: Padding(
            padding: context.paddingLow,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const _Header(),
                  Padding(
                    padding: context.paddingNormal,
                    child: firebaseui.LoginView(
                      action: firebaseui.AuthAction.signIn,
                      providers: firebaseui.FirebaseUIAuth.providersFor(
                          FirebaseAuth.instance.app),
                    ),
                  ),
                  if (ref.watch(authProvider).isRedirect)
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        StringConstants.continueToApp,
                        style: context.textTheme.bodyMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(text: StringConstants.loginWelcomeBack),
        Padding(
          padding: context.onlyTopPaddingLow,
          child: SubTitleText(
            text: StringConstants.loginWelcomeDetail,
          ),
        ),
      ],
    );
  }
}
