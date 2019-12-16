import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:flutter_app/store/Index.dart';
import 'package:flutter_app/utils/DateFormatUtil.dart';

/// @description: 创建任务
/// @author:xhxie
/// @date: 2019-11-27
class CreateMissionPage extends StatefulWidget {
  @override
  _CreateMissionPageState createState() => _CreateMissionPageState();
}

class _CreateMissionPageState extends State<CreateMissionPage> {
  String date = DateFormatUtil.getInstance().format(new DateTime.now(), "yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建任务"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          children: <Widget>[
            Row(
//              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("提醒日期："),
                FlatButton.icon(
                    label: Text(
                      date,
                      style: TextStyle(
                          color: Store.value<SharedValuesModel>(context).theme),
                    ),
                    icon: Icon(
                      Icons.expand_more,
                      color: Store.value<SharedValuesModel>(context).theme,
                    ),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime.now().subtract(new Duration(days: 30)),
                              lastDate: new DateTime(new DateTime.now().year + 2)
                      ).then((DateTime dateTime) {
                            setState(() {
                              if(null != dateTime) {
                                date = DateFormatUtil.getInstance().format(
                                    dateTime, "yyyy-MM-dd");
                              }
                            });
                      }).catchError((error) {
                        print(error);
                      });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
