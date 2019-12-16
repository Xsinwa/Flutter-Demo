import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PendingPage extends StatefulWidget{

  @override
  _PendingPageState createState() {
    // TODO: implement createState
    return new _PendingPageState();
  }
}

class _PendingPageState extends State<PendingPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //不显示返回按钮
        title: Text("待办事项"),
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
        child: Text("这是待办事项"),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}