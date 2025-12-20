import 'package:flutter/material.dart';
import 'package:flutter_project/components/Booking/AptsWithDate.dart';
import 'package:flutter_project/data/models/House.dart';

class CanceledBooking extends StatefulWidget {
  Map<String, List<House>> apts = {
    // "2020.5.12":[new House(), new House(), new House()],
    // "2029.4.1":[new House(), new House()]
  };
  State<CanceledBooking> createState() => _CanceledBooking();
}

class _CanceledBooking extends State<CanceledBooking> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Aptswithdate(apts: widget.apts,cardHeight: constraints.maxHeight,cardWidth: constraints.maxWidth,)
          );
        },
      ),
    );
  }
}
