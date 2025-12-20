class Notification {
  String? notificationId;
  String? customerId;
  String? msg;
  NotificationStatus? status;
  bool isRead = false;
}

enum NotificationStatus { forCustomer, forProvider }
