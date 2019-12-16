import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:flutter_app/store/Index.dart';

class CurrentMissionPage extends StatefulWidget{

  @override
  _CurrentMissionPageState createState() {
    return new _CurrentMissionPageState();
  }
}

class _CurrentMissionPageState extends State<CurrentMissionPage> with AutomaticKeepAliveClientMixin {
  List curDatas = new List();
  List loadDatas = new List();
  int count = 0;
  int _curIndex = -1;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, //不显示返回按钮
        title: Text("今日任务"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
//                _onShared();
              }),
        ],
      ),
      body: ListView.separated(
        addAutomaticKeepAlives: true,
        itemBuilder: (context, index) {
          if (index == curDatas.length - 1) {
            count++;
            _retrieveData();
            if (loadDatas.length != 0) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(strokeWidth: 2.0)),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ));
            }
          }
          //显示列表项
          return itemWidget(index);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey,
            height: .0,
          );
        },
        itemCount: curDatas.length,
      ),
    );
  }

  /// * 获取数据
  void _retrieveData() {
    Future.delayed(Duration(seconds: 1)).then((e) {
      loadDatas.clear();
      if (count < 2) {
        for (int i = 0; i < 20; i++) {
          loadDatas.add(i);
        }
      }
      setState(() {
        //重新构建列表
        curDatas.addAll(loadDatas);
      });
    });
  }

  /// * ListView item布局
  Widget itemWidget(int index) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Offstage(
          offstage: false,
          child: ListTile(
            leading: Image.network(
                "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
            title: Text(curDatas[index].toString()),
            subtitle: Text(curDatas[index].toString()),
            trailing: Text(curDatas[index].toString()),
            onTap: () {
              _onItemPressed(index);
            },
            onLongPress: () {
              _onItemLongPressed(index);
            },
          ),
        ),
        Offstage(
          offstage: (_curIndex == index) ? false : true,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                    padding: const EdgeInsets.all(17.0),
                    color: Colors.grey,
                    shape: CircleBorder(side: BorderSide.none),
                    onPressed: () {
                      _cancel();
                    },
                    child: Text(
                      "取消",
                      style: TextStyle(color: Colors.white),
                    )),
                FlatButton(
                    padding: const EdgeInsets.all(17.0),
                    color: Store.value<SharedValuesModel>(context).theme,
                    shape: CircleBorder(side: BorderSide.none),
                    onPressed: () {},
                    child: Text(
                      "已完成",
                      style: TextStyle(color: Colors.white),
                    )),
                FlatButton(
                  padding: const EdgeInsets.all(17.0),
                  color: Colors.red,
                  shape: CircleBorder(side: BorderSide.none),
                  child: Text(
                    "删除",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _deleteMission(_curIndex);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///点击item
  void _onItemPressed(int index) {}

  ///* item长按
  void _onItemLongPressed(int index) {
    setState(() {
      _curIndex = index;
    });
  }

  /// 取消
  void _cancel() {
    setState(() {
      _curIndex = -1;
    });
  }

  ///删除
  void _deleteMission(int index) {
    setState(() {
      curDatas.removeAt(index);
      _curIndex = -1;
    });
  }

  Widget missionItem(int index) {
    return Column(
      children: <Widget>[
        Text(curDatas[index].toString()),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}