import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var information;
  static const informations = [
    {'username': 'hedie-ka', 'password': '2224008'},
  ];
  Box? _box;
  DataStored? data;

  @override
  void initState() {
    Hive.openBox('Information').then((value) {
      setState(() {
        _box = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: true, body: BodyUi());
  }

  BodyUi() {
    if (_box == null) {
      return CircularProgressIndicator();
    } else {
      return ValueListenableBuilder(
        valueListenable: _box!.listenable(),
        builder: (context, _box, Widget) {
          return FutureBuilder(
            future: loadData(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Scaffold(
                  body: Container(
                    color: Colors.pink,
                  ),
                );
              } else {
                return Scaffold(
                    body: Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Stack(
                          children: [
                            Positioned(
                              height: MediaQuery.of(context).size.height * 0.48,
                              width: MediaQuery.of(context).size.width * 1,
                              child: Image.asset(
                                  'assets/images/main_background.jpg'),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.05,
                              child: Image.asset(
                                'assets/images/item1.jpg',
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.35,
                              child: Image.asset('assets/images/item2.jpg'),
                            ),
                            Positioned(
                              right: MediaQuery.of(context).size.width * 0.05,
                              top: MediaQuery.of(context).size.height * 0.08,
                              child: Image.asset('assets/images/clock.jpg'),
                            ),
                            Positioned(
                                top: MediaQuery.of(context).size.height * 0.25,
                                left: MediaQuery.of(context).size.width * 0.35,
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontFamily: 'Byekan',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        )),
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                            ),
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromARGB(
                                              255, 240, 240, 240),
                                          spreadRadius: 5,
                                          blurRadius: 5,
                                          offset: Offset(0.0, 0.75))
                                    ]),
                                child: Form(
                                    key: formKey,
                                    child: Column(children: [
                                      TextFormField(
                                        controller: usernameController,
                                        decoration: const InputDecoration(
                                            hintText: 'Email or Phone number',
                                            hintStyle: TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: 'Byekan'),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please fill this field.';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            hintText: 'Password',
                                            hintStyle: TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: 'Byekan'),
                                            border: InputBorder.none),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please fill this field.';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ])),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top:
                                      MediaQuery.of(context).size.height * 0.03,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.06,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                width: MediaQuery.of(context).size.width,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      data = DataStored(usernameController.text,
                                          passwordController.text);
                                      if (!validate(snapshot)) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Text(
                                                        'نام کاربری یا رمزعبور اشتباه است.'))));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child:
                                                        Text('ورود موفق.'))));
                                      }
                                    }
                                  },
                                  color: const Color.fromARGB(255, 71, 87, 179),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Byekan',
                                    ),
                                  ),
                                ),
                              ),
                              const InkWell(
                                child: Text(
                                  'Frgot Password?',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Byekan',
                                    color: Color.fromARGB(255, 71, 87, 179),
                                  ),
                                ),
                              ),
                            ])))
                  ],
                ));
              }
            },
          );
        },
      );
    }
  }

  Future<Map> loadData() async {
    //_box!.clear();
    var username = await _box?.get('username', defaultValue: 'hedie-ka');
    var password = await _box?.get('password', defaultValue: '2224008');
    if (informations[0].values.toList().first == username &&
        informations[0].values.toList().last == password) {
      information = informations[0];
    }
    return information;
  }

  bool validate(AsyncSnapshot snapshot) {
    if (snapshot.data['username'] == data?.getUsername()) {
      if (snapshot.data['password'] == data?.getPassword()) return true;
      return false;
    }
    return false;
  }
}

class DataStored {
  String? username;
  String? password;

  DataStored(String newUsername, String newPassword) {
    username = newUsername;
    password = newPassword;
  }

  @override
  String toString() {
    return ('username: $username  password: $password');
  }

  void setUsername(String username) {
    username = username;
  }

  void setPassword(String password) {
    password = password;
  }

  String? getUsername() {
    return username;
  }

  String? getPassword() {
    return password;
  }
}
