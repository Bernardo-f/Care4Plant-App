import 'package:shared_preferences/shared_preferences.dart';

class Plant {
  final int id;
  String imgLevel1;
  String imgLevel2;
  String imgLevel3;
  String imgLevel4;
  String imgLevel5;

  Plant(
      {required this.id,
      required this.imgLevel1,
      required this.imgLevel2,
      required this.imgLevel3,
      required this.imgLevel4,
      required this.imgLevel5});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'] as int,
      imgLevel1: json['img_level_1'].toString(),
      imgLevel2: json['img_level_2'].toString(),
      imgLevel3: json['img_level_3'].toString(),
      imgLevel4: json['img_level_4'].toString(),
      imgLevel5: json['img_level_5'].toString(),
    );
  }

  List<String> getListImages() {
    return [imgLevel1, imgLevel2, imgLevel3, imgLevel4, imgLevel5];
  }

  void savePlant() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("myPlant", getListImages());
  }
}
