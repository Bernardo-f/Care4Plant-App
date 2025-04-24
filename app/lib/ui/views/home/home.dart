// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:care4plant/core/services/l10n/l10n_service.dart';
import 'package:care4plant/domain/usecases/get_acceso_invernadero_usecase.dart';
import 'package:care4plant/ui/provider/greenhouse_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../injection_container.dart';

import '../helpers/snackbar_utils.dart';
import 'CareCenter/care_center.dart';
import 'Greenhouse/greenhouse.dart';
import 'MyPlant/my_plant.dart';
import 'UserCenter/user_center.dart';
import 'Widgets/appbar.dart';
import 'Widgets/home_Bottom_Navigation_Bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final colorTabSelected =
      const ColorFilter.mode(Color.fromRGBO(203, 223, 223, 1), BlendMode.srcIn);
  int currentTab = 1;

  void handleTabChange(int index) async {
    if (index == 3) {
      final accesoInvernadero = await sl<GetAccesoInvernaderoUseCase>().call();
      if (!(accesoInvernadero ?? false)) {
        SnackbarUtils.showNoAccessMessage(context);
        return;
      }
    }
    setState(() {
      currentTab = index;
    });
  }

  void backToMyPlant() {
    setState(() {
      currentTab = 1;
    });
  }

  List<Widget> get pages => [
        const UserCenter(),
        MyPlant(changeTab: handleTabChange),
        const CareCenter(),
        ChangeNotifierProvider(
          create: (_) => GreenhouseProvider(sl(), sl(), sl(), sl())..init(),
          child: const Greenhouse(),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(currentTab, backToMyPlant, context),
      backgroundColor: Colors.white,
      bottomNavigationBar: HomeBottomNavigationBar(
        currentTab: currentTab,
        onTabChange: handleTabChange,
        colorFilter: colorTabSelected,
      ),
      body: pages[currentTab],
    );
  }
}

void showMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        L10nService.localizations.noAccesoInvernadero,
        style: const TextStyle(
            color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold, fontSize: 17),
      ),
      backgroundColor: const Color.fromRGBO(227, 235, 228, 1),
      duration: const Duration(milliseconds: 4000),
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0, vertical: 10 // Inner padding for SnackBar content.
          ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
