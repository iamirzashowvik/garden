import 'dart:math';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:garden/main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Garden extends StatefulWidget {
  List<dynamic> p;int vaild;
  int x;
  final String name;final double width;
  Garden(this.p, this.x, this.name,this.width,this.vaild);
  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  String email;
  getDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    email = preferences.getString('email');
  }

  List<dynamic> _imageUris = [];
  double width;
  double height;
  bool visible;final fireStoreInstance = FirebaseFirestore.instance;
  int variableSet = 0;
  ScrollController _scrollController;
  @override
  void initState() {getDate();
    _imageUris = widget.p;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: DragAndDropGridView(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:(widget.width/7.5).toInt(),
                    childAspectRatio: 3 / 4.5,
                  ),
                  padding: EdgeInsets.all(20),
                  itemBuilder: (context, index) => Card(
                    elevation: 2,
                    child: LayoutBuilder(
                      builder: (context, costrains) {
                        if (variableSet == 0) {
                          height = costrains.maxHeight;
                          width = costrains.maxWidth;
                          variableSet++;
                        }
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                                builder: (context) => new CupertinoAlertDialog(
                                      title: new Column(
                                        children: <Widget>[
                                          new Text("Tree"),
                                          new Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                      content: new Text(_imageUris[index]),
                                      actions: <Widget>[
                                        new TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: new Text("Ok"))
                                      ],
                                    ),
                                barrierDismissible: false,
                                context: context);
                          },
                          onDoubleTap: () => setState(() {
                            _imageUris[index] = '';
                          }),
                          child: GridTile(
                              child: Container(
                                  //color: Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),

                                  child: Center(
                                      child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _imageUris[
                                  index], //style: TextStyle(fontSize: 5),
                            ),
                          )))),
                        );
                      },
                    ),
                  ),
                  itemCount: _imageUris.length,
                  onWillAccept: (oldIndex, newIndex) {
                    // Implement you own logic

                    // Example reject the reorder if the moving item's value is something specific
                    if (_imageUris[newIndex] == "something") {
                      return false;
                    }
                    return true; // If you want to accept the child return true or else return false
                  },
                  onReorder: (oldIndex, newIndex) {
                    final temp = _imageUris[oldIndex];
                    _imageUris[oldIndex] = _imageUris[newIndex];
                    _imageUris[newIndex] = temp;

                    setState(() {});
                  },
                ),
              ),
         widget.vaild==0?     Container():ElevatedButton(onPressed: () {

           fireStoreInstance
               .collection("Users")
               .doc(email)
               .set({

             'email': email,

             'timestamp': FieldValue.serverTimestamp(),
           }, SetOptions(merge: true)).then((_) async {
             print("success!");
             fireStoreInstance
                 .collection("Users")
                 .doc(email)
                 .collection("Gardens")
                 .doc()
                 .set({
               'tree_list':widget.p,
               'length':widget.width,
               'timestamp': FieldValue.serverTimestamp(),
             }, SetOptions(merge: true)).then((_) {
               print('success');
               Get.snackbar('Successful','Your Garden is saved');
               Get.offAll(MyHomePage());
             });
           });

         }, child: Text('Save'))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ScrollController>(
        '_scrollController', _scrollController));
  }
}
