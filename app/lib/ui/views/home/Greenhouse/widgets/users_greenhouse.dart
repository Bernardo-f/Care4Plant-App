import 'package:care4plant/env.dart';
import 'package:care4plant/models/user_greenhouse.dart';
import 'package:care4plant/ui/provider/cuidadores_greenhouse_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../../../../core/services/l10n/l10n_service.dart';
import '../../../../../injection_container.dart';
import '../../../../provider/zone_greenhouse_provider.dart';
import '../../../components/circular_primary_indicator.dart';
import '../../../helpers/layout_helpers.dart';
import '../zone.dart';

class UsersGreenhouse extends StatefulWidget {
  final String acceptLanguage;
  const UsersGreenhouse({Key? key, required this.acceptLanguage}) : super(key: key);

  @override
  UsersGreenhouseState createState() => UsersGreenhouseState();
}

class UsersGreenhouseState extends State<UsersGreenhouse> {
  int page = 0;
  double startX = 0.0;
  double endX = 0.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Tooltip.dismissAllToolTips();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CuidadoresGreenhouseProvider>(builder: (context, provider, child) {
      return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 10),
        height: heightPercentage(.6, context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture(
              const AssetBytesLoader("assets/img/background_greenhouse.svg.vec"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: heightPercentage(.6, context),
            ),
            (provider.state == CuidadoresGreenhouseProviderState.loading)
                ? const Align(
                    alignment: Alignment.center,
                    child: circularPrimaryColorIndicator,
                  )
                : (provider.pageGreenhouse!.usersGreenhouse.isNotEmpty)
                    ? Stack(
                        children: [
                          GestureDetector(
                              onHorizontalDragDown: (details) {
                                startX = details.globalPosition.dx;
                              },
                              onHorizontalDragUpdate: (details) {
                                endX = details.globalPosition.dx;
                              },
                              onHorizontalDragEnd: (details) {
                                double distance = endX - startX;
                                if (distance.abs() >= 100) {
                                  if (details.velocity.pixelsPerSecond.dx > 0) {
                                    // Deslizamiento de izquierda a derecha
                                    if (provider.page != 0) {
                                      provider.changePage(provider.page - 1);
                                    }
                                  } else {
                                    // Deslizamiento de derecha a izquierda
                                    if (provider.pageGreenhouse!.nextPage) {
                                      provider.changePage(provider.page + 1);
                                    }
                                  }
                                }
                              },
                              child: Container(
                                height: double.infinity,
                                color: Colors.transparent,
                                child: buildTest(provider.pageGreenhouse!.usersGreenhouse),
                              )),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                if (provider.page != 0)
                                  IconButton(
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        provider.changePage(provider.page - 1);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        size: 50,
                                        color: Color.fromRGBO(61, 87, 50, 1),
                                      )),
                                const Spacer(),
                                if (provider.pageGreenhouse!.nextPage)
                                  IconButton(
                                      visualDensity: VisualDensity.compact,
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        provider.changePage(provider.page + 1);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 50,
                                        color: Color.fromRGBO(61, 87, 50, 1),
                                      )),
                              ],
                            ),
                          )
                        ],
                      )
                    : Container(
                        color: Colors.transparent,
                        height: double.infinity,
                        width: 200,
                        alignment: Alignment.center,
                        child: Text(
                          L10nService.localizations.noMoreResults,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
          ],
        ),
      );
    });
  }
}

Widget buildTest(List<UserGreenhouse> users) {
  return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: (users.length <= 1)
          ? 1
          : (users.length > 1 && users.length <= 3)
              ? 2
              : (users.length > 3 && users.length <= 6)
                  ? 3
                  : 4,
      itemBuilder: ((context, rowIndex) {
        final startIndex = (rowIndex == 0)
            ? 0
            : (rowIndex == 1)
                ? 1
                : (rowIndex == 2)
                    ? 3
                    : 6;
        final endIndex = (rowIndex == 0)
            ? 1
            : (rowIndex == 1 && users.length >= 3)
                ? 3
                : (rowIndex == 2 && users.length >= 6)
                    ? 6
                    : users.length;
        final rowItems = users.sublist(startIndex, endIndex);
        int indexElement = startIndex;
        return Container(
          margin: (rowIndex == 0)
              ? EdgeInsets.only(top: heightPercentage(.14, context))
              : (rowIndex == 1)
                  ? EdgeInsets.only(left: 80, top: heightPercentage(.02, context))
                  : EdgeInsets.only(top: heightPercentage(.02, context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: rowItems.map((item) {
              final user = Padding(
                padding: (indexElement == 0)
                    ? EdgeInsets.zero
                    : (indexElement == 1 || indexElement == 3 || indexElement == 6)
                        ? const EdgeInsets.only(right: 5)
                        : (indexElement == 2 || indexElement == 5 || indexElement == 8)
                            ? const EdgeInsets.only(
                                left: 5,
                              )
                            : const EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  onDoubleTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                create: (_) => ZoneGreenhouseProvider(sl(), sl(), sl(), sl())
                                  ..init(item.email),
                                child: Zone(userGreenhouse: item))));
                  },
                  child: Tooltip(
                      message: item.name,
                      triggerMode: TooltipTriggerMode.tap,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                      child: SvgPicture.network(
                        apiUrl + item.plant,
                        fit: BoxFit.scaleDown,
                        height: heightPercentage(.1, context),
                      )),
                ),
              );
              indexElement++;
              return user;
            }).toList(),
          ),
        );
      }));
}
