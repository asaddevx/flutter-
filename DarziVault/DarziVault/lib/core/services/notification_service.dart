import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:uuid/uuid.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/notification_model.dart';
import '../../data/models/order_model.dart';
import '../constants/hive_boxes.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  final _uuid = const Uuid();
  bool _initialized = false;

  FlutterLocalNotificationsPlugin get plugin => _plugin;

  Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // Request permissions on Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _initialized = true;
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - navigation handled by the app
  }

  // ─── Notification Channels ─────────────────────────────────────
  static const _orderChannel = AndroidNotificationDetails(
    'order_reminders',
    'Order Reminders',
    channelDescription: 'Reminders for order due dates',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  static const _overdueChannel = AndroidNotificationDetails(
    'overdue_alerts',
    'Overdue Alerts',
    channelDescription: 'Alerts for overdue orders',
    importance: Importance.max,
    priority: Priority.max,
    icon: '@mipmap/ic_launcher',
  );

  static const _paymentChannel = AndroidNotificationDetails(
    'payment_reminders',
    'Payment Reminders',
    channelDescription: 'Reminders for pending payments',
    importance: Importance.high,
    priority: Priority.high,
    icon: '@mipmap/ic_launcher',
  );

  static const _statusChannel = AndroidNotificationDetails(
    'status_updates',
    'Status Updates',
    channelDescription: 'Order status change notifications',
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
    icon: '@mipmap/ic_launcher',
  );

  // ─── Schedule Order Due Reminders ─────────────────────────────
  Future<void> scheduleOrderReminders(OrderModel order) async {
    if (order.dueDate == null) return;

    final settingsBox = Hive.box(HiveBoxes.settings);
    final notificationsEnabled = settingsBox.get('notifications_enabled', defaultValue: true) as bool;
    if (!notificationsEnabled) return;

    final dueDateRemindersEnabled = settingsBox.get('due_date_reminders', defaultValue: true) as bool;
    if (!dueDateRemindersEnabled) return;

    // Cancel existing reminders for this order
    await cancelOrderReminders(order.id);

    final dueDate = order.dueDate!;
    final now = DateTime.now();

    // Schedule 3-day reminder
    final threeDaysBefore = dueDate.subtract(const Duration(days: 3));
    if (threeDaysBefore.isAfter(now)) {
      await _scheduleNotification(
        id: _generateNotificationId(order.id, '3day'),
        title: 'Order Due in 3 Days',
        titleUrdu: 'آرڈر 3 دن میں واجب الادا',
        body: '${order.clientName} - ${order.garmentType}',
        bodyUrdu: '${order.clientName} - ${order.garmentType}',
        scheduledDate: threeDaysBefore,
        channel: _orderChannel,
        type: 'order_due_3days',
        relatedId: order.id,
      );
    }

    // Schedule 1-day reminder
    final oneDayBefore = dueDate.subtract(const Duration(days: 1));
    if (oneDayBefore.isAfter(now)) {
      await _scheduleNotification(
        id: _generateNotificationId(order.id, '1day'),
        title: 'Order Due Tomorrow!',
        titleUrdu: 'آرڈر کل واجب الادا ہے!',
        body: '${order.clientName} - ${order.garmentType}',
        bodyUrdu: '${order.clientName} - ${order.garmentType}',
        scheduledDate: oneDayBefore,
        channel: _orderChannel,
        type: 'order_due_tomorrow',
        relatedId: order.id,
      );
    }

    // Schedule overdue notification (on due date + 1 day)
    final overdueDate = dueDate.add(const Duration(days: 1));
    if (overdueDate.isAfter(now)) {
      final overdueEnabled = settingsBox.get('overdue_alerts', defaultValue: true) as bool;
      if (overdueEnabled) {
        await _scheduleNotification(
          id: _generateNotificationId(order.id, 'overdue'),
          title: 'Order Overdue!',
          titleUrdu: 'آرڈر کی تاریخ گزر گئی!',
          body: '${order.clientName} - ${order.garmentType} is past due date',
          bodyUrdu: '${order.clientName} - ${order.garmentType} کی تاریخ گزر گئی',
          scheduledDate: overdueDate,
          channel: _overdueChannel,
          type: 'order_overdue',
          relatedId: order.id,
        );
      }
    }
  }

  // ─── Payment Pending Notification ─────────────────────────────
  Future<void> showPaymentPendingNotification(OrderModel order) async {
    final settingsBox = Hive.box(HiveBoxes.settings);
    final notificationsEnabled = settingsBox.get('notifications_enabled', defaultValue: true) as bool;
    if (!notificationsEnabled) return;

    final paymentRemindersEnabled = settingsBox.get('payment_reminders', defaultValue: true) as bool;
    if (!paymentRemindersEnabled) return;

    if (order.balanceAmount <= 0) return;

    await _showImmediateNotification(
      title: 'Payment Pending',
      titleUrdu: 'ادائیگی باقی ہے',
      body: '${order.clientName} - PKR ${order.balanceAmount.toStringAsFixed(0)} remaining',
      bodyUrdu: '${order.clientName} - PKR ${order.balanceAmount.toStringAsFixed(0)} باقی',
      channel: _paymentChannel,
      type: 'payment_pending',
      relatedId: order.id,
    );
  }

  // ─── Status Update Notification ───────────────────────────────
  Future<void> showStatusUpdateNotification(OrderModel order, String newStatus) async {
    final settingsBox = Hive.box(HiveBoxes.settings);
    final notificationsEnabled = settingsBox.get('notifications_enabled', defaultValue: true) as bool;
    if (!notificationsEnabled) return;

    final statusUpdatesEnabled = settingsBox.get('status_updates', defaultValue: true) as bool;
    if (!statusUpdatesEnabled) return;

    await _showImmediateNotification(
      title: 'Order Status Updated',
      titleUrdu: 'آرڈر کی حالت تبدیل ہوئی',
      body: '${order.clientName} - ${order.garmentType}: $newStatus',
      bodyUrdu: '${order.clientName} - ${order.garmentType}: $newStatus',
      channel: _statusChannel,
      type: 'status_update',
      relatedId: order.id,
    );
  }

  // ─── Cancel Reminders ─────────────────────────────────────────
  Future<void> cancelOrderReminders(String orderId) async {
    await _plugin.cancel(_generateNotificationId(orderId, '3day'));
    await _plugin.cancel(_generateNotificationId(orderId, '1day'));
    await _plugin.cancel(_generateNotificationId(orderId, 'overdue'));
  }

  // ─── Private Helpers ──────────────────────────────────────────
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String titleUrdu,
    required String body,
    required String bodyUrdu,
    required DateTime scheduledDate,
    required AndroidNotificationDetails channel,
    required String type,
    String? relatedId,
  }) async {
    final notificationDetails = NotificationDetails(
      android: channel,
      iOS: const DarwinNotificationDetails(),
    );

    try {
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Fallback: save to in-app notifications if scheduling fails
    }

    // Also save to in-app notification storage
    _saveInAppNotification(
      title: title,
      titleUrdu: titleUrdu,
      body: body,
      bodyUrdu: bodyUrdu,
      type: type,
      relatedId: relatedId,
      scheduledAt: scheduledDate,
    );
  }

  Future<void> _showImmediateNotification({
    required String title,
    required String titleUrdu,
    required String body,
    required String bodyUrdu,
    required AndroidNotificationDetails channel,
    required String type,
    String? relatedId,
  }) async {
    final notificationDetails = NotificationDetails(
      android: channel,
      iOS: const DarwinNotificationDetails(),
    );

    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    
    await _plugin.show(id, title, body, notificationDetails);

    // Save to in-app notifications
    _saveInAppNotification(
      title: title,
      titleUrdu: titleUrdu,
      body: body,
      bodyUrdu: bodyUrdu,
      type: type,
      relatedId: relatedId,
    );
  }

  void _saveInAppNotification({
    required String title,
    required String titleUrdu,
    required String body,
    required String bodyUrdu,
    required String type,
    String? relatedId,
    DateTime? scheduledAt,
  }) {
    final box = Hive.box<NotificationModel>(HiveBoxes.notifications);
    final notification = NotificationModel(
      id: _uuid.v4(),
      title: title,
      titleUrdu: titleUrdu,
      body: body,
      bodyUrdu: bodyUrdu,
      type: type,
      isRead: false,
      createdAt: scheduledAt ?? DateTime.now(),
      relatedId: relatedId,
    );
    box.add(notification);
  }

  int _generateNotificationId(String orderId, String suffix) {
    return '${orderId}_$suffix'.hashCode.abs() % 2147483647;
  }

  // ─── Check & Generate Overdue Notifications ───────────────────
  Future<void> checkOverdueOrders() async {
    final settingsBox = Hive.box(HiveBoxes.settings);
    final notificationsEnabled = settingsBox.get('notifications_enabled', defaultValue: true) as bool;
    if (!notificationsEnabled) return;

    final overdueEnabled = settingsBox.get('overdue_alerts', defaultValue: true) as bool;
    if (!overdueEnabled) return;

    final orderBox = Hive.box<OrderModel>(HiveBoxes.orders);
    final now = DateTime.now();
    
    for (final order in orderBox.values) {
      if (order.dueDate != null && 
          order.dueDate!.isBefore(now) &&
          order.status != 'delivered' &&
          order.status != 'cancelled') {
        // Check if we already sent overdue notification today
        final notifBox = Hive.box<NotificationModel>(HiveBoxes.notifications);
        final alreadySent = notifBox.values.any((n) =>
          n.relatedId == order.id &&
          n.type == 'order_overdue' &&
          n.createdAt.day == now.day &&
          n.createdAt.month == now.month &&
          n.createdAt.year == now.year
        );
        
        if (!alreadySent) {
          await _showImmediateNotification(
            title: 'Order Overdue!',
            titleUrdu: 'آرڈر کی تاریخ گزر گئی!',
            body: '${order.clientName} - ${order.garmentType} is past due date',
            bodyUrdu: '${order.clientName} - ${order.garmentType} کی تاریخ گزر گئی',
            channel: _overdueChannel,
            type: 'order_overdue',
            relatedId: order.id,
          );
        }
      }
    }
  }

  // ─── Check Payment Pending ────────────────────────────────────
  Future<void> checkPendingPayments() async {
    final settingsBox = Hive.box(HiveBoxes.settings);
    final notificationsEnabled = settingsBox.get('notifications_enabled', defaultValue: true) as bool;
    if (!notificationsEnabled) return;

    final paymentEnabled = settingsBox.get('payment_reminders', defaultValue: true) as bool;
    if (!paymentEnabled) return;

    final orderBox = Hive.box<OrderModel>(HiveBoxes.orders);
    final now = DateTime.now();
    
    for (final order in orderBox.values) {
      if (order.balanceAmount > 0 &&
          (order.status == 'completed' || order.status == 'delivered')) {
        final notifBox = Hive.box<NotificationModel>(HiveBoxes.notifications);
        final alreadySent = notifBox.values.any((n) =>
          n.relatedId == order.id &&
          n.type == 'payment_pending' &&
          n.createdAt.day == now.day &&
          n.createdAt.month == now.month &&
          n.createdAt.year == now.year
        );
        
        if (!alreadySent) {
          await _showImmediateNotification(
            title: 'Payment Pending',
            titleUrdu: 'ادائیگی باقی ہے',
            body: '${order.clientName} - PKR ${order.balanceAmount.toStringAsFixed(0)} remaining',
            bodyUrdu: '${order.clientName} - PKR ${order.balanceAmount.toStringAsFixed(0)} باقی',
            channel: _paymentChannel,
            type: 'payment_pending',
            relatedId: order.id,
          );
        }
      }
    }
  }
}
