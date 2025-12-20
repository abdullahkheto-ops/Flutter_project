import 'package:flutter_project/data/models/House.dart';

class Favourite {
  String? favouriteId;
  String? userId;
  String? houseId;
  
  static List<House> apts = [];

  static void addApt(House apt) {
    if (!apts.contains(apt)) {
      apts.add(apt);
    }
  }

  static void removeApt(House apt) {
    apts.remove(apt);
  }

  static bool isFavourite(House apt) {
    return apts.contains(apt);
  }
}
