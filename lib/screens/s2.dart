import 'package:flutter/material.dart';
import 'package:garden/screens/seegarden.dart';
import 'package:get/get.dart';

class S2 extends StatefulWidget {
  final double area; final double width;
  final String name;

S2(this.name,this.width,this.area);
  @override
  _S2State createState() => _S2State();
}

class _S2State extends State<S2> {List<String> selectedtree = [];  List<String> trees = ['mango', 'apple','orange'];
  @override
  Widget build(BuildContext context) {
 int x=   widget.area.toInt();
    return Scaffold(
appBar: AppBar(title: Text(widget.name),
),
body: Center(
  child:   Column(

    children: [



      Text('You can plant approximately ${(widget.area/(7.5*7.5)).floor()} plants')
     , Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          selectedtree.length.toString(),
          style: TextStyle(color: Colors.green, fontSize: 35),
        ),
      ),
      (widget.area/(7.5*7.5)).floor()==selectedtree.length?
      ElevatedButton(onPressed: (){
        print(x);
        Get.to(Garden(selectedtree,x,widget.name,widget.width,1
      ));}, child: Text('See Garden')): Expanded(
        flex: 1,
        //height: 300,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: trees.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {setState(() {
                      selectedtree.add(trees[index]);
                    });
                    },
                    child: Text(trees[index])),
              );
            }),
      ),

    ],

  ),
),
    );
  }
}
