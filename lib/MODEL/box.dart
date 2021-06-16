
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryXx extends StatefulWidget {
  final String name;
  // final String name2;
  final String iimage;
  CategoryXx(this.name, this.iimage);

  @override
  _CategoryXxState createState() => _CategoryXxState();
}

class _CategoryXxState extends State<CategoryXx> {
  @override
  void initState() {
    random();
    super.initState();
  }

  int p = 0;

  int random() {
    var rng = new Random();
    p = rng.nextInt(colorList.length);
    return p;
  }

  List<Color> colorList = [
    Color(0xfffeecbb),
    Color(0xffc3f0dc),
    Color(0xfff9B7c8),
    Color(0xffb5ccFe),
    Color(0xffafdbfb),
    Color(0xffd3b2fe),
    Colors.greenAccent,
    Color(0xff9CC2F4),
    Color(0xffC69CF4),
    Color(0xffD1FAF0),
    Color(0xffF4DC9C),
    Color(0xff66A1EE),
    Color(0xff66D7EE),
    Color(0xff9CF4DF),
    Color(0xffBCEE66),
    Color(0xffEE66AA),
    Color(0xffA866EE),
    Color(0xffF4B69C),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: colorList[p],
            border: Border.all(color: Colors.white.withOpacity(0.08)),
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blueAccent,
                backgroundImage: NetworkImage(widget.iimage),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Text(widget.name,

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        // backgroundColor: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Gilroy',
                      )),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.all(5.0),
            //   child: AutoSizeText(widget.name,
            //       minFontSize: 10,
            //       maxLines: 1,
            //       overflow: TextOverflow.ellipsis,
            //       style: TextStyle(
            //         // backgroundColor: Colors.white,
            //         fontSize: 20,
            //         fontFamily: 'Gilroy',
            //       )),
            // ),
          ],
        ),
      ),
    );
  }
}