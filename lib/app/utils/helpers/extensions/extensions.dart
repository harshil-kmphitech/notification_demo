import 'dart:convert';
import 'dart:math' as math;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/snackbar/snackbar_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

extension SharedPreferencesX on SharedPreferences {
  String? get getToken {
    return getString('token');
  }

  set setToken(String? value) {
    if (value == null) {
      remove('token');
    } else {
      setString('token', value);
    }
  }

  String? get getFirebaseToken {
    return getString('firebase_token');
  }

  set setFirebaseToken(String? value) {
    if (value == null) {
      remove('firebase_token');
    } else {
      setString('firebase_token', value);
    }
  }

  String? get getUserId {
    return getString('UserId');
  }

  set setUserId(String? value) {
    if (value == null) {
      remove('UserId');
    } else {
      setString('UserId', value);
    }
  }

  String? get getAppLocal {
    return getString('appLocal');
  }

  set setAppLocal(String? value) {
    if (value == null) {
      remove('appLocal');
    } else {
      setString('appLocal', value);
    }
  }

  // set setLoginData(AuthData loginResponse) {
  //   final allData = jsonEncode(loginResponse);
  //   setString('loginData', allData);
  //
  //   setString('UserId', loginResponse.id ?? '');
  //   setString('token', loginResponse.token ?? '');
  // }
  //
  // set nullLoginData(AuthData? loginResponse) {
  //   remove('loginData');
  // }

  /// <<< --------- To Read Login Data --------- >>>
  // AuthData get getLoginData {
  //   if (containsKey('loginData')) {
  //     final result = getString('loginData');
  //     final data = jsonDecode(result!) as Map<String, dynamic>;
  //     return AuthData.fromJson(data);
  //   } else {
  //     return AuthData();
  //   }
  // }

  Future removeAllData() async {
    // nullLoginData = null;
    setToken = null;
    setUserId = null;
    // getIt.resetLazySingleton<SocketService>();
    // await Get.offAllNamed(AppRoutes.loginMobile);
  }
}

extension StringX on String {
  String get convertMd5 => md5.convert(utf8.encode(this)).toString();
}

extension BuildContextX on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

extension SnackbarX on String {
  SnackbarController showAsSnackBar({Duration duration = const Duration(seconds: 2)}) => Get.showSnackbar(
    GetSnackBar(
      message: this,
      borderRadius: 10,
      duration: duration,
      padding: const EdgeInsets.all(12),
      margin: MediaQuery.paddingOf(Get.context!).min(bottom: 16, left: 16, right: 16),
    ),
  );
}

extension EdgeInsetsX on EdgeInsets {
  EdgeInsets min({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left == null ? this.left : math.max(left, this.left),
      right: right == null ? this.right : math.max(right, this.right),
      top: top == null ? this.top : math.max(top, this.top),
      bottom: bottom == null ? this.bottom : math.max(bottom, this.bottom),
    );
  }
}

extension ShimmerExtension on Widget {
  Widget shimmer({
    Color? baseColor,
    Color? highlightColor,
    Duration duration = const Duration(seconds: 1),
  }) {
    return Shimmer.fromColors(
      period: duration,
      baseColor: baseColor ?? Colors.grey.shade400,
      highlightColor: highlightColor ?? Colors.grey.shade200,
      child: this,
    );
  }
}

