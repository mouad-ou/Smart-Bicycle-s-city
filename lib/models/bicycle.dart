import 'package:bicycle_renting/utils/utilFunctions.dart';

class Bicycle {
  final String? id;
  final String? make;
  final String? model;
  final double? price;
  final String? location;
  final String? availability;
  final String? imageUrl;

  Bicycle(
      {this.id,
      this.make,
      this.model,
      this.price,
      this.location,
      this.availability,
      this.imageUrl});
  factory Bicycle.fromJson(Map<String, dynamic> json) {
    return Bicycle(
        id: MyFunct.getStringFromJson(json, 'id'),
        make: MyFunct.getStringFromJson(json, 'make'),
        model: MyFunct.getStringFromJson(json, 'model'),
        price: MyFunct.getDoubleFromJson(json, 'price'),
        location: MyFunct.getStringFromJson(json, 'location'),
        availability: MyFunct.getStringFromJson(json, 'availability'));
  }

  Map<String, dynamic> toJson() => {
        'make': make,
        'model': model,
        'price': price,
        'location': location,
        'availability': availability
      };
}
