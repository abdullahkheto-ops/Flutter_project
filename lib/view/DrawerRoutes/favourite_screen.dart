import 'package:flutter/material.dart';
import 'package:flutter_project/components/PageShowcards.dart';
import 'package:flutter_project/components/homePage/ShowAptsVertical1.dart';
import 'package:flutter_project/data/models/House.dart';
import 'package:flutter_project/data/models/favourite.dart';

class FavouriteScreen extends StatefulWidget {
  double cardwidth;
  double cardHeight;
  FavouriteScreen({required this.cardHeight, required this.cardwidth});
  State<FavouriteScreen> createState() => _FavouriteScreen();
}

class _FavouriteScreen extends State<FavouriteScreen> {
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PageShowcards(
        cardHeight: widget.cardHeight,
        cardwidth: widget.cardwidth,
        apts: Favourite.apts,
        msg: "No Favorite Apts",
      ),
    );
  }
}
