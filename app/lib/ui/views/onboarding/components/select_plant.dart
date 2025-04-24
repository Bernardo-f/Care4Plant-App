import 'package:care4plant/models/user_settings.dart';
import 'package:care4plant/env.dart';
import 'package:care4plant/ui/provider/get_all_plants_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../theme/app_colors.dart';

class SelectPlant extends StatefulWidget {
  final Function(int) onPlantSelected;
  final UserSetting userSetting;

  const SelectPlant({Key? key, required this.onPlantSelected, required this.userSetting})
      : super(key: key);
  @override
  SelectPlantState createState() => SelectPlantState();
}

class SelectPlantState extends State<SelectPlant> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<GetAllPlantsProvider>(context, listen: false);
      if (provider.state == GetAllPlantsState.idle) {
        provider.getAllPlants();
      }
    });
  }

  void _changePlant(int id) {
    setState(() {
      widget.onPlantSelected(id);
    });
  }

  @override
  bool get wantKeepAlive => true; // Keep the state of this widget alive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build to keep the state alive
    return Consumer<GetAllPlantsProvider>(builder: (context, getAllPlantsProvider, child) {
      if (getAllPlantsProvider.state == GetAllPlantsState.success) {
        return Expanded(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: getAllPlantsProvider.plants.length,
                itemBuilder: ((context, index) {
                  final plant = getAllPlantsProvider.plants[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: InkWell(
                      onTap: () => _changePlant(plant.id),
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(239, 254, 247, 1),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.network(
                              (apiUrl + plant.imgLevel2),
                              fit: BoxFit.cover,
                              width: 75,
                              height: 75,
                              placeholderBuilder: (context) {
                                return const CircularProgressIndicator(
                                  color: primaryColor,
                                );
                              },
                            ),
                            if (widget.userSetting.PlantId == plant.id) const CheckIcon(),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
      } else if (getAllPlantsProvider.state == GetAllPlantsState.loading) {
        return const Center(
          child: CircularProgressIndicator(color: primaryColor),
        );
      } else {
        return Center(
          child: Text(
            getAllPlantsProvider.errorMessage ?? "Error loading plants",
            style: const TextStyle(color: primaryColor, fontSize: 20),
          ),
        );
      }
    });
  }
}

class CheckIcon extends StatelessWidget {
  const CheckIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(239, 254, 247, .6),
      ),
      child: const Icon(Icons.check, color: Color.fromRGBO(61, 87, 50, 1), size: 70),
    );
  }
}
