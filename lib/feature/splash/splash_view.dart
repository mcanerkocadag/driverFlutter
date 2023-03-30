import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/feature/home/home_view.dart';
import 'package:flutter_application_firebase/feature/splash/splash_provider.dart';
import 'package:flutter_application_firebase/product/constants/color_constants.dart';
import 'package:flutter_application_firebase/product/constants/string_constants.dart';
import 'package:flutter_application_firebase/product/enums/image_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashViewListenMixin {
  final splashProvider =
      StateNotifierProvider<SplashProvider, SplashState>((ref) {
    return SplashProvider();
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(splashProvider.notifier).checkApplicationVersion(''.version);
  }

  @override
  Widget build(BuildContext context) {
    listenAndNavigate(splashProvider);
    return Scaffold(
      backgroundColor: ColorConstants.purpleDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconConstants.appIcon.toImage,
            Text(
              StringConstants.appName,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: ColorConstants.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
      StateNotifierProvider<SplashProvider, SplashState> splashProvider) {
    ref.listen(splashProvider, (previous, next) {
      if (next.isRequiredForceUpdate == true) {
        showAboutDialog(context: context);
        return;
      }

      if (next.isRedirectHome != null) {
        if (next.isRedirectHome!) {
          context.navigateToPage(HomeView());
        } else {
          //false
        }
      }
    });
  }
}
