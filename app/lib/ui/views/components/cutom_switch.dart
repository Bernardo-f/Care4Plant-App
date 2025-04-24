import 'package:flutter/material.dart';

import '../../../core/services/notifications/notifications_service.dart';
import '../helpers/show_notifications.dart';

Widget customSwitch(bool value, Function(bool) onChanged, BuildContext context) {
  return SizedBox(
    height: 40,
    child: FittedBox(
      child: Theme(
          data: ThemeData(useMaterial3: true),
          child: Switch.adaptive(
            value: value,
            thumbColor:
                MaterialStateColor.resolveWith((states) => const Color.fromRGBO(219, 227, 219, 1)),
            thumbIcon: const MaterialStatePropertyAll(Icon(
              Icons.abc,
              color: Colors.transparent,
            )),
            // trackOutlineWidth: const MaterialStatePropertyAll(0),
            trackColor: MaterialStateColor.resolveWith(((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromRGBO(61, 87, 50, 1);
              }
              return const Color.fromARGB(255, 119, 121, 119);
            })),
            onChanged: (bool value) async {
              if (value == true) {
                bool? granted = await NotificationsService().requestPermissions();
                if (granted!) {
                  onChanged(value);
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showMessageNotifications(context);
                  });
                }
              } else {
                onChanged(value);
              }
            },
          )),
    ),
  );
}
