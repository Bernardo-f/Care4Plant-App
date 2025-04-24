import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:flutter/material.dart';

import '../../../../models/user_settings.dart';
import '../../../../core/services/notifications/notifications_service.dart';
import 'page_settings.dart';

class Notifications extends StatefulWidget {
  final UserSetting userSetting;
  final Function(bool) changeNotificationTest;
  final Function(bool) changeNotificationActividades;
  const Notifications(
      {Key? key,
      required this.userSetting,
      required this.changeNotificationTest,
      required this.changeNotificationActividades})
      : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}

const TextStyle textStyle =
    TextStyle(fontFamily: "Open Sans", color: Color.fromRGBO(107, 103, 122, 1), fontSize: 19);

class NotificationsState extends State<Notifications> {
  final NotificationsService notificationsService = NotificationsService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          L10nService.localizations.forStressLevel,
          style: textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () async {
                  bool? granted = await notificationsService.requestPermissions();
                  if (granted!) {
                    widget.changeNotificationTest(true);
                  }
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) async {
                        bool? granted = await notificationsService.requestPermissions();
                        if (granted!) {
                          widget.changeNotificationTest(true);
                        }
                      },
                      value: true,
                      groupValue: widget.userSetting.notificacionTest,
                    ),
                    textOption(L10nService.localizations.yesOption)
                  ],
                )),
            GestureDetector(
                onTap: () {
                  widget.changeNotificationTest(false);
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) {
                        widget.changeNotificationTest(false);
                      },
                      value: false,
                      groupValue: widget.userSetting.notificacionTest,
                    ),
                    textOption(L10nService.localizations.noOption)
                  ],
                ))
          ],
        ),
        Text(
          L10nService.localizations.forActivities,
          style: textStyle,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () async {
                  bool? granted = await notificationsService.requestPermissions();
                  if (granted!) {
                    widget.changeNotificationActividades(true);
                  }
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) async {
                        bool? granted = await notificationsService.requestPermissions();
                        if (granted!) {
                          widget.changeNotificationActividades(true);
                        }
                      },
                      value: true,
                      groupValue: widget.userSetting.notificacionActividades,
                    ),
                    textOption(L10nService.localizations.yesOption)
                  ],
                )),
            GestureDetector(
                onTap: () {
                  widget.changeNotificationActividades(false);
                },
                child: Row(
                  children: [
                    Radio<bool?>(
                      activeColor: Colors.black,
                      onChanged: (value) {
                        widget.changeNotificationActividades(false);
                      },
                      value: false,
                      groupValue: widget.userSetting.notificacionActividades,
                    ),
                    textOption(L10nService.localizations.noOption)
                  ],
                ))
          ],
        )
      ],
    );
  }
}
