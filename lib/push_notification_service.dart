import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_office/features/Home/business%20logic/cubit/cubit/item_cubit.dart';
import 'package:office_office/features/barista_home/business_logic/get_all_orders_cubit.dart';
import 'package:office_office/local_notification.dart';
import 'core/constants/strings.dart';
import 'features/Home/business logic/cubit/cubit/my_orders_cubit.dart';
import 'main.dart';

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static Future init() async {
    await messaging.requestPermission();
    AppConstants.fcmToken = await messaging.getToken();
    log("FCM Token: ${AppConstants.fcmToken} ");
    FirebaseMessaging.onBackgroundMessage(handlerMessaging);
    _handleForegroundMessage();
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final title = message.notification?.title ?? message.data['title'] ?? "";

      if (title.contains("New item:")) {
        _refreshItems();
      } else {
        _refreshOrders();
      }
    });
  }

  static Future<void> handlerMessaging(RemoteMessage message) async {
    final title = message.notification?.title ?? message.data['title'] ?? "";

    if (title.contains("New item:")) {
      _refreshItems();
    } else {
      _refreshOrders();
    }
  }

  static void _handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.showBasicNotification(message);
      final title = message.notification?.title ?? message.data['title'] ?? "";
      if (title.contains("New item:")) {
        _refreshItems();
      } else {
        _refreshOrders();
      }
    });
  }

  static void _refreshOrders() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      try {
        if (AppConstants.role == "employee") {
          context.read<GetMyOrdersCubit>().getAllOrders();
        }
        if (AppConstants.role == "barista") {
          context.read<GetAllOrdersCubit>().getAllOrders();
        }
        log("Orders refreshed after notification");
      } catch (e) {
        log(" Failed to refresh orders: $e");
      }
    } else {
      log(" No context available to refresh orders");
    }
  }

  static void _refreshItems() {
    final context = navigatorKey.currentContext;
    if (context != null) {
      BlocProvider.of<ItemCubit>(context).getAllItems();
      log("Items refreshed after notification");
    } else {
      log(" No context available to refresh orders");
    }
  }
}
