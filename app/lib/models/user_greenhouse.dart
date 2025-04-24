// ignore_for_file: non_constant_identifier_names

class UserGreenhouse {
  final String email;
  final String name;
  final String plant;
  UserGreenhouse({required this.email, required this.name, required this.plant});

  factory UserGreenhouse.fromJson(Map<String, dynamic> json) {
    return UserGreenhouse(
        name: json['nombre'].toString(),
        email: json['email'].toString(),
        plant: json['plant'].toString());
  }
}
