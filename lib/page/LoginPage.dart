import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool remSwitchSelected = false;
  bool autoSwitchSelected = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名或邮箱",
                      prefixIcon: Icon(Icons.person)),
                ),
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "登陆密码",
                      prefixIcon: Icon(Icons.lock)),
                  obscureText: true, //隐藏密码
                ),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: remSwitchSelected,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {
                                  remSwitchSelected = value;
                                });
                              }),
                          Text("记住密码"),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Checkbox(
                            value: autoSwitchSelected,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                autoSwitchSelected = value;
                              });
                            },
                          ),
                          Text("自动登陆"),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: RaisedButton(
                    onPressed: (){
                      _toHomePage();
                    },
                    child: Text("登陆"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 跳转至首页
  void _toHomePage(){
    Navigator.pushNamedAndRemoveUntil(context, "home_page", (route) => route == null);
  }
}
