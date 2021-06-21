import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:garden/MODEL/box.dart';
import 'package:garden/screens/seegarden.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/s1.dart';

//asss
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//njnj
  runApp(GetMaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool auth;
  String email;

  Future<UserCredential> signInWithGoogleee() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  getDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      auth = preferences.getBool('islogin');
      email = preferences.getString('email');
      getDataFromFirebase();
    });
  }

  var dataFF;
  List<dynamic> g = [];
  List<dynamic> gFinal = [];
  var gfx;
  double gLength;
  getDataFromFirebase() async {
    var res2 = await FirebaseFirestore.instance
        .collection("Users")
        .doc(email)
        .collection('Gardens')
        .get();

    res2.docs.forEach((result) {
      dataFF = result.data();
      // print( result.data()['tree_list']);

      setState(() {
        g.add(dataFF);
      });
    });

    counttest++;
    if (counttest == 1) {
      gFinal = g;
      gfx = gFinal.length;
    }
  }

  int counttest = 0;

  @override
  void initState() {
    getDate();

    // TODO: implement initState
    super.initState();
  }

  final _loginForm = GlobalKey<FormState>();
  TextEditingController _userName = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('GARDEN APP'),
      ),
      body: auth == true
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.to(GetArea('Garden Deshi'));
                      },
                      child: Text('Make Garden Deshi')),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(GetArea('Garden Abroad'));
                      },
                      child: Text('Make Garden')),
                  ElevatedButton(
                      onPressed: () {
                        Get.to(GetArea('Wooden Garden'));
                      },
                      child: Text('Wooden Garden n')),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: gFinal.length,
                      itemBuilder: (context, i) {
                        print(gFinal[i]['tree_list']);
                        return ListTile(
                          title: Text('Garden Number $i'),
                          onTap: () {
                            Get.to(Garden(gFinal[i]['tree_list'], 20, 'Garden',
                                gFinal[i]['length'], 0));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Form(
                key: _loginForm,
                child: Column(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          signInWithGoogleee().then((result) async {
                            if (result != null) {
                              print(
                                  'uid ${result.user.uid} ${result.credential} ${result.additionalUserInfo.providerId}');
                              firestoreInstance
                                  .collection("client")
                                  .doc(result.user.email)
                                  .set({
                                'profile': result.additionalUserInfo.profile,
                              }, SetOptions(merge: true)).then((_) async {
                                setState(() {
                                  auth = true;
                                });
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setBool('islogin', true);
                                preferences.setString(
                                    'email', result.user.email);
                              });
                            }
                          });
                        },
                        child: Text('Sign In with Google')),
                    Text('or'),
                    TFFxMx(_userName, 'with your email'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_loginForm.currentState.validate()) {
                            firestoreInstance
                                .collection("client")
                                .doc(_userName.text)
                                .set({
                              'profile': _userName.text,
                            }, SetOptions(merge: true)).then((_) async {
                              setState(() {
                                auth = true;
                              });
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.setBool('islogin', true);
                              preferences.setString('email', _userName.text);
                            });
                          } else {}
                        },
                        child: Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
