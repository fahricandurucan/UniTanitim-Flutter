
import 'dart:io';
import 'package:flutter/material.dart';
class ImageViewPage extends StatelessWidget {
  String link;


  ImageViewPage(this.link);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Color(0xff00c3ff),
          backgroundColor: Color(0xff00222d),

        ),
        backgroundColor: Color(0xff00222d),
        body: InteractiveViewer(
          child: Image.network(
            link,
            fit: BoxFit.contain,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),

      ),
    );
  }
}
