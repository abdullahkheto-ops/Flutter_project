import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool darkMode = false;
  bool arabic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Dark Mode",style: Theme.of(context).textTheme.bodyMedium),
            value: darkMode,
            onChanged: (val) {
              setState(() {
                darkMode = val;
              });
            },
          ),
          SwitchListTile(
            title: Text("Arabic",style: Theme.of(context).textTheme.bodyMedium,),
            value: arabic,
            onChanged: (val) {
              setState(() {
                arabic = val;
              });
            },
          ),
        ],
      ),
    );
  }
}
