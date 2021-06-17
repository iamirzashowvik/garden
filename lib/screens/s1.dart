import 'package:flutter/material.dart';
import 'package:garden/screens/s2.dart';
import 'package:get/get.dart';

class GetArea extends StatefulWidget {
 final String name;
 GetArea(this.name);

  @override
  _GetAreaState createState() => _GetAreaState();
}

class _GetAreaState extends State<GetArea> {final _loginForm = GlobalKey<FormState>();
TextEditingController _userName = TextEditingController();
TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Form(
        key: _loginForm,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TFFxM(_userName, 'width'),
            TFFxM(_password, 'length'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_loginForm.currentState.validate()) {
                    double r=int.parse(_userName.text).toDouble() * int.parse(_password.text).toDouble() ;
                    print(r.toString());
                   Get.to(S2(widget.name,int.parse(_userName.text).toDouble(),r));
                  } else {}
                },
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class TFFxM extends StatelessWidget {
  TFFxM(this._userName, this.imptyText);

  final TextEditingController _userName;
  final String imptyText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _userName,
          validator: (value) {
            if (value.isEmpty) {
              return '$imptyText can not be empty';
            }
            else if(int.parse(value)<8){
              return 'value can not be less than 8';
            }

            return null;
          },
          keyboardType: TextInputType.number,
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.circular(10)),

            filled: true,

            border: InputBorder.none,
            hintText: imptyText,

          ),
        ),
      ),
    );
  }
}
class TFFxMx extends StatelessWidget {
  TFFxMx(this._userName, this.imptyText);

  final TextEditingController _userName;
  final String imptyText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: _userName,
          validator: (value) {
            if (value.isEmpty) {
              return '$imptyText can not be empty';
            }

            return null;
          },
          keyboardType: TextInputType.emailAddress,
          decoration: new InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.circular(10)),

            filled: true,

            border: InputBorder.none,
            hintText: imptyText,

          ),
        ),
      ),
    );
  }
}