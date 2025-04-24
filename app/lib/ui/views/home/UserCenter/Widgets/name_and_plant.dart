import 'package:care4plant/env.dart';
import 'package:care4plant/ui/provider/name_and_plant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NameAndPlant extends StatefulWidget {
  const NameAndPlant({Key? key}) : super(key: key);

  @override
  NameAndPlantState createState() => NameAndPlantState();
}

class NameAndPlantState extends State<NameAndPlant> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NameAndPlantProvider>(builder: (context, provider, child) {
      return (provider.name != null && provider.plant != null)
          ? Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/plant-background.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.network(
                      apiUrl + provider.plant!,
                      fit: BoxFit.contain,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Text(provider.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(61, 87, 50, 1),
                      fontSize: 20,
                    ))
              ],
            )
          : const SizedBox.shrink();
    });
  }
}
