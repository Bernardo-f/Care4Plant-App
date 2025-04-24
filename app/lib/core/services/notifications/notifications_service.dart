// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages, unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';
import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:care4plant/domain/usecases/get_notificacion_actividades_usecase.dart';
import 'package:care4plant/domain/usecases/get_notificacion_test_usecase.dart';
import 'package:care4plant/env.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// Peticiones http
import 'package:http/http.dart' as http;

import '../../../injection_container.dart';
import '../storage/secure_storage_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_care4plant');
final InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
  // iOS: initializationSettingsDarwin,
  // macOS: initializationSettingsDarwin,
  // linux: initializationSettingsLinux,
);
final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();
AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
    'Care4plantId', 'Care4plantChannel',
    channelDescription: 'your channel description',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker');

class NotificationsService {
  Future<bool?> requestPermissions() async {
    if (Platform.isIOS) {
      final bool? granted = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      return granted;
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      final bool? granted = await androidImplementation?.requestPermission();
      return granted;
    }
    return false;
  }

  Future<void> saveActivitiesNotification() async {
    bool? notificacionActividades = await sl<GetNotificacionActividadesUseCase>().call();
    if (!notificacionActividades!) {
      return;
    }
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == 1) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        L10nService.localizations.titleNotificationActivities,
        L10nService.localizations.bodyNotificationActivities,
        tz.TZDateTime.now(tz.local).add(timeNotificationActivities),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> saveTestNotification(BuildContext context) async {
    bool? notificacionTest = await sl<GetNotificacionTestUseCase>().call();
    if (!notificacionTest!) {
      return;
    }
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == 1) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    tz.initializeTimeZones();
    final SecureStorageService _storage = SecureStorageService();
    final token = await _storage.getToken();
    final requestDate = await http.get(Uri.parse("$apiUrl/api/StressTest/GetDateNotification"),
        headers: {'Authorization': 'Bearer $token'});
    if (requestDate.statusCode != 200) {
      return;
    }
    DateTime dateNotification = DateTime.parse(requestDate.body.replaceAll('"', ''));
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        AppLocalizations.of(context)!.titleNotificationTest,
        AppLocalizations.of(context)!.bodyNotificationTest,
        tz.TZDateTime.from(dateNotification.toLocal(), tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  }

  Future<void> clearNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelNotificationTest() async {
    await flutterLocalNotificationsPlugin.cancel(2);
  }

  Future<void> cancelNotificationActividades() async {
    await flutterLocalNotificationsPlugin.cancel(1);
  }
}
