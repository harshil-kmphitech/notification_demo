import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:notification_demo/app/utils/helpers/exception/exception.dart';
import 'package:notification_demo/app/utils/helpers/extensions/extensions.dart';
import 'package:notification_demo/app/utils/helpers/injectable/injectable.dart';
import 'package:notification_demo/app/utils/helpers/loading.dart';
import 'package:notification_demo/app/utils/helpers/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueueRequest<T> {
  QueueRequest({
    required this.err,
    required this.handler,
  });

  final DioException err;

  final ErrorInterceptorHandler handler;

  void next() {
    handler.next(err);
  }

  Future<void> resolve() {
    final requestOptions = err.requestOptions;
    requestOptions.extra['new-Token'] = getIt<SharedPreferences>().getToken;
    return getIt<Dio>().fetch(_recreateOptions(requestOptions)).handler(
      null,
      isLoading: false,
      onSuccess: handler.resolve,
      onFailed: (value) {
        if (value.dioError != null) {
          debugPrintStack(stackTrace: value.dioError?.stackTrace, label: value.dioError?.response?.data.toString());
          handler.reject(value.dioError!);
        } else {
          handler.next(err);
        }
      },
    );
  }

  static RequestOptions _recreateOptions(RequestOptions options) {
    return RequestOptions(
      headers: {
        ...options.headers,
      },
      data: options.data,
      baseUrl: options.baseUrl,
      path: options.path,
      cancelToken: options.cancelToken,
      connectTimeout: options.connectTimeout,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      validateStatus: options.validateStatus,
      onReceiveProgress: options.onReceiveProgress,
      onSendProgress: options.onSendProgress,
      contentType: options.contentType,
      responseType: options.responseType,
      extra: options.extra,
      method: options.method,
      queryParameters: options.queryParameters,
    );
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor();

  final List<QueueRequest<dynamic>> requestQueue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getIt<SharedPreferences>().getToken;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    options.headers['lang'] = getIt<SharedPreferences>().getAppLocal ?? 'en';

    if (options.extra.containsKey('new-Token')) {
      options.extra['new-Token'].toString().log;
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      Loading.dismiss();
      await getIt<SharedPreferences>().removeAllData();
    } else if (err.response?.statusCode == 433) {
      _queueRequest(err, handler);
    } else {
      super.onError(err, handler);
    }
  }

  void _queueRequest(DioException err, ErrorInterceptorHandler handler) {
    requestQueue.add(
      QueueRequest(
        err: err,
        handler: handler,
      ),
    );

    if (refreshTokenState.isInitial) {
      // refreshToken();
    }
  }

  final refreshTokenState = ApiState.initial();

  // Future<void> refreshToken() async {
  //   final data = getIt<SharedPreferences>().getUserId;
  //   if (data != null) {
  //     await getIt<RefreshTokenService>().refreshToken(data).handler(
  //       refreshTokenState,
  //       isLoading: false,
  //       onSuccess: _onRefreshSuccess,
  //       onFailed: _rejectQueuedRequests,
  //     );
  //   } else {
  //     requestQueue
  //       ..forEach((element) => element.next())
  //       ..clear();
  //   }
  // }

  void _rejectQueuedRequests(FailedState value) {
    for (final element in requestQueue) {
      element.next();
    }
    requestQueue.clear();
  }

  // void _onRefreshSuccess(RefreshTokenResponseModel value) {
  //   final pref = getIt<SharedPreferences>();
  //
  //   if (value.data.containsKey('token')) {
  //     pref.setToken = value.data['token'] as String;
  //   } else {
  //     requestQueue
  //       ..forEach((element) => element.next())
  //       ..clear();
  //
  //     return;
  //   }
  //   refreshTokenState.value = InitialState();
  //
  //   Future.wait(
  //     requestQueue.map((e) => e.resolve()),
  //   ).whenComplete(requestQueue.clear);
  // }
}
