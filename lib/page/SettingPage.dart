import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/store/Index.dart';
import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:flutter_app/utils/SharedPreferencesUtil.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 0.0),
            child: Container(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 50),
              child: Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Icon(
                    Icons.alarm_on,
                    color: Store.value<SharedValuesModel>(context).theme,
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text("任务提醒"),
                    ),
                  ),
                  Switch(
                    value: Store.value<SharedValuesModel>(context).openRemind,
                    onChanged: (value) {
                      setState(() {
                        Store.value<SharedValuesModel>(context).setOpenRemind(value);
                        SharedPreferencesUtil.set("openRemind", value);
                      });
                    },
                  ),
                ],
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
            child: Container(
              constraints:
                  BoxConstraints.tightFor(width: double.infinity, height: 50),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.language,
                      color: Store.value<SharedValuesModel>(context).theme,
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
                      color: Store.value<SharedValuesModel>(context).theme,
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
