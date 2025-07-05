import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notification_demo/app/utils/helpers/logger.dart';

import 'exception/exception.dart';

mixin PaginationHelper {
  late final scrollController = ScrollController()
    ..addListener(_scrollListener);

  final end = false.obs;

  final apiState = ApiState.initial();

  void _scrollListener() {
    if (end.value ||
        apiState.isLoading ||
        scrollController.offset <
            scrollController.position.maxScrollExtent.log - 70) return;
    scrollListener();
  }

  void scrollListener();

  void removeListenerAndDispose() {
    scrollController
      ..removeListener(_scrollListener)
      ..dispose();
  }
}

class Pagination with PaginationHelper {
  Pagination(this.onFetchData);

  VoidCallback onFetchData;

  @override
  void scrollListener() {
    onFetchData();
  }
}
