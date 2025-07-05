import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notification_demo/app/controllers/notifications_controller.dart';
import 'package:notification_demo/app/ui/widgets/custom_image_view.dart';
import 'package:notification_demo/app/utils/helpers/exception/exception.dart';
import 'package:notification_demo/app/utils/helpers/extensions/extensions.dart';
import 'package:notification_demo/app/utils/helpers/getItHook/getit_hook.dart';

import '../../utils/constants/app_strings.dart';

class NotificationScreen extends GetItHook<NotificationsController> {
  const NotificationScreen({super.key});

  @override
  bool get autoDispose => true;

  @override
  void onInit() {}

  @override
  void onDispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), centerTitle: true),
      body: Obx(
            () =>
        (controller.notificationsApiState.isLoading && controller.notificationModel.isEmpty)
            ? ListView.builder(
          itemCount: 10,
          padding: const EdgeInsets.all(12),
          itemBuilder:
              (context, index) =>
              Container(
                height: 110,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: context.colorScheme.secondary.withValues(alpha: .35)),
              ).shimmer(),
        )
            : controller.notificationModel.isEmpty
            ? const Center(child: Text('NO NOTIFICATIONS AVAILABLE'))
            : ListView.separated(
          padding: const EdgeInsets.all(12),
          controller: controller.scrollController,
          itemCount: controller.notificationModel.length + 1,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            if (index == controller.notificationModel.length) {
              return controller.isPaginationLoading.value ? const Center(child: CircularProgressIndicator()).paddingOnly(bottom: 40) : const SizedBox();
            }
            RxBool showLongDes = false.obs;
            final item = controller.notificationModel[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text('Firebase Demo', style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: context.textTheme.bodyMedium,
                          text: showLongDes.value || (item.message?.length ?? 0) <= 100 ? "${item.message} " : "${item.message?.substring(0, 100) ?? ""}.... ",
                          children:
                          (item.message?.length ?? 0) > 100
                              ? [
                            TextSpan(
                              style: context.textTheme.bodyLarge?.copyWith(color: Colors.blue),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => showLongDes.value = !showLongDes.value,
                              text: showLongDes.value ? 'See less' : 'See more',
                            ),
                          ]
                              : [],
                        ),
                      )),
                    const SizedBox(height: 4),
                    Text(LastTimes.lastTimes(item.createdAt ?? DateTime.now()), style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    // if(item.image?.isNotEmpty ?? false)
                    //   CustomImageView(item.image ?? ''),
                  ],
                ),
                leading: const Icon(Icons.notifications),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LastTimes {
  static String lastTimes(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${AppStrings.T.daysAgo}';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${AppStrings.T.hoursAgo}';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${AppStrings.T.minutesAgo}';
    } else {
      return AppStrings.T.justNow;
    }
  }
}
