import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:injectable/injectable.dart' as i;

import '../data/models/notificationModel/notification_model.dart';
import '../data/services/pushNotificationServices/push_notification_services.dart';
import '../utils/helpers/exception/exception.dart';
import '../utils/helpers/injectable/injectable.dart';

@i.lazySingleton
@i.injectable
class NotificationsController extends GetxController {
  NotificationsController() {
    onInit();
  }

  @override
  void onInit() {
    pageLimit = 1;
    scrollController.addListener(onScroll);
    getNotifications();
    super.onInit();
  }

  RxList<NotiData> notificationModel = <NotiData>[].obs;
  Rx<ApiState> notificationsApiState = ApiState.initial();

  // Pagination variables
  int pageLimit = 1;
  int totalRecords = 0;
  final isPaginationLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  void onScroll() {
    if (scrollController.position.extentAfter <= 0 && notificationModel.length < totalRecords && !isPaginationLoading.value) {
      isPaginationLoading.value = true;
      pageLimit++;
      getNotifications();
    }
  }

  void getNotifications() {
    getIt<PushNotification>()
        .getNotifications(page: 1, limit: 10)
        .handler(
          isLoading: false,
          notificationsApiState,
          onSuccess: (value) {
            totalRecords = value.data?.totalRecords ?? 0;
            if (pageLimit == 1) {
              notificationModel.clear();
            }
            notificationModel.addAll(value.data?.notifications ?? []);
          },
          onFailed: (value) => value.showToast(),
        );
    isPaginationLoading.value = false;
  }

  @i.disposeMethod
  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }
}
