import 'package:care4plant/ui/provider/logout_provider.dart';
import 'package:care4plant/ui/provider/notificaciones_provider.dart';
import 'package:care4plant/ui/provider/preference_provider.dart';
import 'package:care4plant/ui/provider/privacy_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/l10n/l10n_service.dart';
import '../../../../injection_container.dart';
import '../../../provider/name_and_plant_provider.dart';
import 'Widgets/name_and_plant.dart';
import 'Widgets/notifications.dart';
import 'Widgets/preference.dart';
import 'Widgets/privacy.dart';

class UserCenter extends StatefulWidget {
  const UserCenter({Key? key}) : super(key: key);
  @override
  UserCenterState createState() => UserCenterState();
}

class UserCenterState extends State<UserCenter> {
  int isExpanded = -1;
  late LogoutProvider logoutProvider;

  @override
  void initState() {
    super.initState();
    logoutProvider = LogoutProvider(sl());
  }

  void setExpanded(int value) {
    setState(() {
      (value == isExpanded) ? isExpanded = -1 : isExpanded = value;
    });
  }

  _logout() async {
    if (await logoutProvider.logout()) {
      _redirectToWelcome();
    }
  }

  _redirectToWelcome() {
    Navigator.pushNamedAndRemoveUntil(context, "welcome", (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          margin: const EdgeInsets.only(top: 60),
          padding: const EdgeInsets.only(top: 110),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(237, 247, 237, 1),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.elliptical(60, 60), topRight: Radius.elliptical(60, 60)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 7,
                    spreadRadius: 3,
                    offset: const Offset(0, 2))
              ]),
          child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ChangeNotifierProvider(
                      create: (_) => PreferenceProvider(sl(), sl(), sl())..init(),
                      child: Preference(
                        setExpanded: setExpanded,
                        isExpanded: isExpanded,
                      ),
                    ),
                    ChangeNotifierProvider(
                      create: (_) => PrivacyProvider(sl(), sl())..init(),
                      child: Privacy(setExpanded: setExpanded, isExpanded: isExpanded),
                    ),
                    ChangeNotifierProvider(
                        create: (_) => NotificacionesProvider(sl(), sl(), sl(), sl())..init(),
                        child: Notifications(setExpanded: setExpanded, isExpanded: isExpanded)),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 50)),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        style: TextButton.styleFrom(backgroundColor: Colors.red),
                        label: Text(
                          L10nService.localizations.logout,
                          style: const TextStyle(color: Colors.white),
                        ),
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          _logout();
                        },
                      ),
                    )
                  ],
                ),
              )),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: ChangeNotifierProvider(
            create: (_) => NameAndPlantProvider(sl(), sl())..init(),
            child: const NameAndPlant(),
          ),
        ),
      ],
    );
  }
}
