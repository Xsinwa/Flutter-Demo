import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget{

  @override
  _HistoryPageState createState() {
    return new _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //不显示返回按钮
        title: Text("历史任务"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
//                _onShared();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text("这是历史任务"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}