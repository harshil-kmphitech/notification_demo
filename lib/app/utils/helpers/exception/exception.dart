// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_demo/app/utils/helpers/loading.dart';
import 'package:notification_demo/app/utils/helpers/logger.dart';

import '../../constants/app_strings.dart' show AppStrings;

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionX on DioException {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          AppStrings.T.connectionTimeout,
          AppStrings.T.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          AppStrings.T.sendTimeout,
          AppStrings.T.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          AppStrings.T.receiveTimeout,
          AppStrings.T.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          AppStrings.T.badCertificate,
          AppStrings.T.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          AppStrings.T.badResponse,
          _statusCode(response?.statusCode ?? 0),
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          AppStrings.T.cancel,
          AppStrings.T.cancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          AppStrings.T.connectionError,
          AppStrings.T.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
        return UserFriendlyError(
          AppStrings.T.unknown,
          AppStrings.T.unknownDesc,
        );
    }
  }

  String _statusCode(int? statusCode) {
    final res = response?.data;
    if (res is Map<String, dynamic>) {
      if (res.containsKey('message')) {
        return '${res['message']}';
      }
    }
    return switch (statusCode) {
      200 => AppStrings.T.code200,
      201 => AppStrings.T.code201,
      202 => AppStrings.T.code202,
      301 => AppStrings.T.code301,
      302 => AppStrings.T.code302,
      304 => AppStrings.T.code304,
      400 => AppStrings.T.code400,
      401 => AppStrings.T.code401,
      403 => AppStrings.T.code403,
      404 => AppStrings.T.code404,
      405 => AppStrings.T.code405,
      409 => AppStrings.T.code409,
      500 => AppStrings.T.code500,
      503 => AppStrings.T.code503,
      _ => '',
    };
  }
}

extension DioExceptionTypeX on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError({
    String? badResponseDesc,
  }) {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          AppStrings.T.connectionTimeout,
          AppStrings.T.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          AppStrings.T.sendTimeout,
          AppStrings.T.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          AppStrings.T.receiveTimeout,
          AppStrings.T.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          AppStrings.T.badCertificate,
          AppStrings.T.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          AppStrings.T.badResponse,
          badResponseDesc ?? AppStrings.T.badResponseDesc,
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          AppStrings.T.cancel,
          AppStrings.T.cancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          AppStrings.T.connectionError,
          AppStrings.T.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
        return UserFriendlyError(
          AppStrings.T.unknown,
          AppStrings.T.unknownDesc,
        );
    }
  }
}

typedef ApiSuccessCallback<T> = void Function(T value);

typedef ApiFailedCallback = void Function(FailedState value);

extension ApiHandlingExtension<T> on Future<T> {
  /// Must use handler it's a better way to handle request's response api calling
  /// Must use handler it's a better way to handle request's response api calling
  Future<void> handler(
      Rx<ApiState>? state, {
        bool isLoading = true,
        ApiFailedCallback? onFailed,
        ApiSuccessCallback<T>? onSuccess,
      }) async {
    try {
      state?.value = LoadingState();
      if (isLoading) Loading.show();
      final response = await this;
      state?.value = SuccessState<T>(response);
      onSuccess?.call(response);
    } on DioException catch (e) {
      final failedState = FailedState(
        statusCode: e.response?.statusCode ?? 0,
        isRetirable: switch (e.type) {
          DioExceptionType.connectionError || DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        dioError: e,
      );
      state?.value = failedState;
      onFailed?.call((state?.value ?? failedState) as FailedState);
    } catch (e) {
      e.log;
      final failedState = FailedState(
        statusCode: 0,
        isRetirable: false,
        dioError: null,
      );
      state?.value = failedState;
      onFailed?.call((state?.value ?? failedState) as FailedState);
    } finally {
      if (isLoading) Loading.dismiss();
    }
  }
}

extension RxApiStateX on Rx<ApiState> {
  bool get isInitial => value is InitialState;
  bool get isLoading => value is LoadingState;
  bool get isSuccess => value is SuccessState;
  bool get isFailed => value is FailedState;
}

extension ApiStateHelper on ApiState {
  bool get isInitial => this is InitialState;
  bool get isLoading => this is LoadingState;
  bool get isSuccess => this is SuccessState;
  bool get isFailed => this is FailedState;
}

sealed class ApiState {
  static Rx<ApiState> initial() => Rx(InitialState());
}

class SuccessState<T> extends ApiState {
  T value;
  SuccessState(this.value);
}

class InitialState extends ApiState {}

class LoadingState extends ApiState {}

class FailedState extends ApiState {
  bool isRetirable;

  UserFriendlyError get error =>
      dioError?.toUserFriendlyError() ??
          UserFriendlyError(
            AppStrings.T.apiError,
            AppStrings.T.apiErrorDescription,
          );

  // Response? get response {
  //   return dioError?.response;
  // }

  DioException? dioError;

  int statusCode;

  FailedState({
    required this.isRetirable,
    required this.statusCode,
    required this.dioError,
  });

  void showToast() {
    Get.showSnackbar(
      GetSnackBar(
        // title: error.title,
        message: messageHelper,
        icon: const Icon(
          Icons.error_outline,
          color: Colors.redAccent,
        ),
        borderColor: Colors.redAccent,
        borderRadius: 10,
        padding: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  String get messageHelper {
    if (dioError?.response?.data is Map<String, dynamic>) {
      return (dioError?.response?.data as Map<String, dynamic>)['message'] as String? ?? error.description;
    } else {
      return error.description;
    }
  }
}
