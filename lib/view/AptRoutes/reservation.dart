import 'package:flutter/material.dart';
import 'package:flutter_project/components/CustomNavBar.dart';
//import 'package:table_calendar/table_calendar.dart';

class Reservation extends StatefulWidget {
  State<Reservation> createState() => _Reservation();
}

class _Reservation extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          // Positioned(left: 20, right: 20, bottom: 20, child: CustomNavBar()),
        
        ],
      ),
      /*body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Text("123"),
              Container(

                child: TableCalendar(
  firstDay: DateTime.utc(2025, 12, 4),
  lastDay: DateTime.utc(2025, 12, 4),
  focusedDay: DateTime.now(),
)

              ),
            ],
          );
        },
      ),*/
    );
  }
}
