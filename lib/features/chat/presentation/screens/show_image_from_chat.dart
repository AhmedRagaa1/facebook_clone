import 'package:flutter/material.dart';

class ShowImage extends StatelessWidget {
   ShowImage({Key? key , this.image}) : super(key: key);
var image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
            image,
            ),
          ),
        ),
      ),
    );
  }
}
