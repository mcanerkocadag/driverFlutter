import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_firebase/product/enums/platform_enum.dart';
import 'package:flutter_application_firebase/product/models/number.dart';
import 'package:flutter_application_firebase/product/utility/firebase/firebase_collections.dart';
import 'package:flutter_application_firebase/product/utility/version/version_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(SplashState());

  Future<void> checkApplicationVersion(String clientVersion) async {
    final dbValue = await getVersionNumberFromDatabase();
    if (dbValue == null || dbValue.isEmpty) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    final checkIsNeedForceUpdate =
        VersionManager(deviceValue: clientVersion, databaseValue: dbValue);
    if (checkIsNeedForceUpdate.isNeedUpdate()) {
      state = state.copyWith(isRequiredForceUpdate: true);
      return;
    }
    state = state.copyWith(isRedirectHome: true);
  }

  Future<String?> getVersionNumberFromDatabase() async {
    if (kIsWeb) return null;

    final response = await FirebaseCollections.version.referance
        .withConverter<Number>(
          fromFirestore: (snapshot, options) {
            return Number().fromFirebase(snapshot) ?? Number();
          },
          toFirestore: ((value, options) {
            return value.toJson();
          }),
        )
        .doc(PlatformEnum.versionName)
        .get();
    return response.data()?.number;
  }
}

class SplashState extends Equatable {
  SplashState({this.isRequiredForceUpdate, this.isRedirectHome});

  final bool? isRequiredForceUpdate;
  final bool? isRedirectHome;

  SplashState copyWith({bool? isRequiredForceUpdate, bool? isRedirectHome}) {
    return SplashState(
      isRequiredForceUpdate:
          isRequiredForceUpdate ?? this.isRequiredForceUpdate,
      isRedirectHome: isRedirectHome ?? this.isRedirectHome,
    );
  }

  @override
  List<Object?> get props => [isRequiredForceUpdate, isRedirectHome];
}
