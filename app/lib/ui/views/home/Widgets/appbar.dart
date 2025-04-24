import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar? getAppBar(currnetPage, Function backToMyPlant, BuildContext context) {
  final appBarList = [
    AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(93, 94, 93, 1),
        ),
        onPressed: () {
          backToMyPlant();
        },
      ),
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 50.0,
      title: Text(
        AppLocalizations.of(context)!.userCenterTitle,
        style: const TextStyle(color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold),
      ),
    ),
    null,
    AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(93, 94, 93, 1),
        ),
        onPressed: () {
          backToMyPlant();
        },
      ),
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 50.0,
      title: Text(
        AppLocalizations.of(context)!.careCenterTitle,
        style: const TextStyle(color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
    ),
    AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(93, 94, 93, 1),
        ),
        onPressed: () {
          backToMyPlant();
        },
      ),
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 50.0,
      title: Text(
        AppLocalizations.of(context)!.greenhouseTitle,
        style: const TextStyle(color: Color.fromRGBO(61, 87, 50, 1), fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
    )
  ];
  return appBarList.elementAt(currnetPage);
}
