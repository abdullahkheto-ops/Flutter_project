import 'package:flutter/material.dart';
import 'package:flutter_project/components/Booking/AptsWithDate.dart';
import 'package:flutter_project/data/models/House.dart';

class PreviousBooking extends StatefulWidget {
  Map<String, List<House>> apts = {
    // "2020.5.12":[new House(), new House(), new House()],
    // "2029.4.1":[new House(), new House()]
  };
  State<PreviousBooking> createState() => _PreviousBooking();
}

class _PreviousBooking extends State<PreviousBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
