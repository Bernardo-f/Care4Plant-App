import 'package:care4plant/ui/provider/get_plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_graphics/vector_graphics.dart';
// Peticiones http
import 'package:care4plant/env.dart';

import '../../../core/services/l10n/l10n_service.dart';

import '../helpers/layout_helpers.dart';
import '../theme/app_colors.dart';

class WelcomeMessageView extends StatefulWidget {
  final String message;
  final Widget Function() nextPageBuilder;
  const WelcomeMessageView({Key? key, required this.message, required this.nextPageBuilder})
      : super(key: key);

  @override
  WelcomeMessageViewState createState() => WelcomeMessageViewState();
}

class WelcomeMessageViewState extends State<WelcomeMessageView> {
  Future<String>? picture;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetPlantProvider>(context, listen: false);
      provider.fetchPlantPicture();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetPlantProvider>(builder: (context, provider, _) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                    child: Text(
                  L10nService.localizations.welcome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "rubik",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromRGBO(58, 60, 62, 1)),
                )),
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: SvgPicture(
                    const AssetBytesLoader('assets/img/Logo.svg.vec'),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                CustomPaint(
                    painter: RPSCustomPainter(),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 90, left: 40, right: 40, top: 40),
                      width: widthPercentage(.8, context),
                      child: Text(
                        widget.message,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color.fromRGBO(79, 75, 75, 1)),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 40),
                          child: provider.imageUrl != null &&
                                  provider.imageUrl!.isNotEmpty &&
                                  !provider.isLoading
                              ? SvgPicture.network(
                                  apiUrl + provider.imageUrl!,
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                )
                              : provider.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text("No se pudo cargar la imagen"),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 40),
                          child: Ink(
                            padding: const EdgeInsets.all(6),
                            decoration:
                                const ShapeDecoration(color: primaryColor, shape: CircleBorder()),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (_) => widget.nextPageBuilder()),
                                    ModalRoute.withName('/'));
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      );
    });
  }
}

//Codigo hecho con https://fluttershapemaker.com/ para que el la imagen de fondo se ajuste al texto
//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2713730, size.height * 0.9550386);
    path_0.arcToPoint(Offset(size.width * 0.2602162, size.height * 0.9515324),
        radius: Radius.elliptical(size.width * 0.01874957, size.height * 0.01799171),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.2516286, size.height * 0.9282146),
        radius: Radius.elliptical(size.width * 0.02383830, size.height * 0.02287475),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.2877703, size.height * 0.7729000);
    path_0.lineTo(size.width * 0.1476258, size.height * 0.7729000);
    path_0.arcToPoint(Offset(size.width * 0.1277264, size.height * 0.7557588),
        radius: Radius.elliptical(size.width * 0.02087866, size.height * 0.02003473),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.006508117, size.height * 0.1419085);
    path_0.arcToPoint(Offset(size.width * 0.009966716, size.height * 0.1247257),
        radius: Radius.elliptical(size.width * 0.02433416, size.height * 0.02335056),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.02425048, size.height * 0.1159291),
        radius: Radius.elliptical(size.width * 0.02005120, size.height * 0.01924072),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.9203407, size.height * 0.01348635);
    path_0.arcToPoint(Offset(size.width * 0.9371068, size.height * 0.01989199),
        radius: Radius.elliptical(size.width * 0.01921444, size.height * 0.01843778),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.9426852, size.height * 0.03785396),
        radius: Radius.elliptical(size.width * 0.02401185, size.height * 0.02304128),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.8629546, size.height * 0.6675370);
    path_0.arcToPoint(Offset(size.width * 0.8427825, size.height * 0.6863227),
        radius: Radius.elliptical(size.width * 0.02121646, size.height * 0.02035888),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.6089180, size.height * 0.6863227);
    path_0.lineTo(size.width * 0.2837849, size.height * 0.9505778);
    path_0.arcToPoint(Offset(size.width * 0.2713885, size.height * 0.9550386),
        radius: Radius.elliptical(size.width * 0.01921444, size.height * 0.01843778),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01239641;
    paint0Stroke.color = const Color(0xff707070).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xffd4dbd6).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
