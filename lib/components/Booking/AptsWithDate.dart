import 'package:flutter/material.dart';
import 'package:flutter_project/components/homePage/ShowAptsVertical1.dart';
import 'package:flutter_project/data/models/House.dart';

class Aptswithdate extends StatefulWidget {
  Map<String, List<House>> apts;
  double cardWidth;
  double cardHeight;
  Aptswithdate({
    required this.apts,
    required this.cardHeight,
    required this.cardWidth,
  });
  State<Aptswithdate> createState() => _Aptswithdate();
}

class _Aptswithdate extends State<Aptswithdate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.apts.entries.map((entry) {
        String date = entry.key;
        List<House> aptsInDate = entry.value;
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      date,
                      style: TextStyle(fontSize:Theme.of(context).textTheme.bodySmall!.fontSize,color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                                top: 25.0,
                                bottom: 25.0,
                                right: 20.0,
                              ),
                      child: Divider(
                        thickness: 1, // سمك الخط
                        color: Theme.of(context).colorScheme.secondary, // لون الخط
                        height: 20, // المسافة حول الـ Divider)
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: aptsInDate.length,
                itemBuilder: (context, i) {
                  return ShowAptsVertical1(
                    cardHeight: widget.cardHeight,
                    cardWidth: widget.cardWidth,
                    apt: aptsInDate[i],
                    classPremission: false,
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
