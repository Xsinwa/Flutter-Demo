import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Index.dart';
import 'package:flutter_app/entity/ThemeConfigModel.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
            child: Container(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 50),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      color: Store.value<ThemeConfigModel>(context).theme,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("语言"),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black12,
                    ),
                  ],
                ),
                onTap: () {
                  /// 跳转至语言选择页
                  Navigator.pushNamed(context, "page_language");
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
            child: Container(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 1),
              color: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0),
            child: GestureDetector(
              child: Container(
                constraints:
                    BoxConstraints.tightFor(width: double.infinity, height: 50),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.color_lens,
                      color: Store.value<ThemeConfigModel>(context).theme,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text("换肤"),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.black12,
                    ),
                  ],
                ),
              ),
              onTap: () {
                /// 跳转至换肤页
                Navigator.pushNamed(context, "page_theme");
              },
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }
}
