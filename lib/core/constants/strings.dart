import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../theming/color_manager.dart';

enum StatusOrder { waiting, onprogress, completed, cancelled }

enum FilterTime { today, week, month, all }

var logger = Logger();

class AppConstants {
  AppConstants._();
  static String? savedToken;
  static String? role;
  static bool isDark = true;
  static String? fcmToken;

  static String getStatusMessage(StatusOrder status) {
    switch (status) {
      case StatusOrder.waiting:
        return "الطلب قيد الانتظار ";
      case StatusOrder.onprogress:
        return "الطلب بدأ يتجهز 🍳";
      case StatusOrder.completed:
        return "الطلب اكتمل ";
      case StatusOrder.cancelled:
        return "الطلب تم إلغاؤه ";
    }
  }

  static Map<StatusOrder, String> statusOrder = {
    StatusOrder.waiting: "onprogress",
    StatusOrder.onprogress: "completed",
  };
  static String translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'waiting':
        return 'قيد الانتظار';
      case 'onprogress':
        return 'قيد التحضير';
      case 'completed':
        return 'مكتمل';
      case 'cancelled':
        return " ملغي";
      default:
        return status;
    }
  }

  static Color getStatusColor(String? status) {
    switch (status) {
      case 'waiting':
        return ColorManager.orangeColor;
      case 'onprogress':
        return ColorManager.primaryColor;
      case 'completed':
        return ColorManager.greenColor;
      case 'cancelled':
        return ColorManager.redColor;
      default:
        return Colors.grey.withOpacity(0.4);
    }
  }
}
