import 'package:flutter/material.dart';

class CustomStarRate extends StatefulWidget {
  State<CustomStarRate> createState() => _CustomStarRate();
}

class _CustomStarRate extends State<CustomStarRate> {
  List<double> rates = [5, 3, 2, 4];
  double iconsSize=18;
  double? averageRate;
  @override
  void initState() {
    averageRate = getAverageRate(rates);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (i) {
        if (i < averageRate!.floor())
          return Icon(Icons.star, color: Colors.yellow, size: iconsSize,);
        else if (i < averageRate!)
          return Icon(Icons.star_half, color: Colors.yellow, size: iconsSize,);
        else
          return Icon(Icons.star, color: Colors.grey, size: iconsSize,);
      }),
    );
  }
}

double getAverageRate(List<double> rates) {
  return rates.isEmpty ? 0 : rates.reduce((a, b) => a + b) / rates.length;
}
