import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Categoriesbutton extends StatelessWidget {
  final VoidCallback onTap;
  double widthScreen;
  double heightScreen;
  String imageUrl;
  String category;

  Categoriesbutton({
    required this.category,
    required this.imageUrl,
    required this.widthScreen,
    required this.heightScreen,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widthScreen * 0.02,
        vertical: heightScreen * 0.02,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          ),
        onPressed: onTap,
        child: Row(
          children: [
            ////////////////////////////////Dealing with pic weither is svg or any
            imageUrl.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    imageUrl,
                    width: widthScreen * 0.08,
                    height: heightScreen * 0.05,
                    //color: Colors.white,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    imageUrl,
                    width: widthScreen * 0.08,
                    height: heightScreen * 0.05,
                    //color: Colors.white,
                    fit: BoxFit.contain,
                  ),
            Container(
              margin: EdgeInsets.all(widthScreen * 0.02),
              child: Text(category, style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
