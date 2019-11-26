import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/ThemeConfigModel.dart';
import 'package:flutter_app/page/MinePage.dart';
import 'package:flutter_app/utils/ToastUtil.dart';
import 'package:flutter_app/widget/LabelIconButton.dart';

import '../store/Index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  var _pageController = new PageController(initialPage: 0);
  int _index = 0;
  DateTime _lastPressedTime;
  MaterialColor _colorToday, _colorTomorrow, _colorHistory, _colorMe;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateViewState(_index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer: new Drawer(),
      body: WillPopScope(
        onWillPop: () async {
          if(null == _lastPressedTime || DateTime.now().difference(_lastPressedTime) > Duration(seconds: 2)){
            _lastPressedTime = DateTime.now();
            ToastUtil.showLongToast("再按一次退出程序");
            return false;
          }
          return true;
        },
        child: PageView.builder(
          onPageChanged: _pageChanged,
          controller: _pageController,
          itemBuilder: (context, index) {
            return _bodyChanged(index);
          },
          itemCount: 4,
        ),
      ),
//      bottomNavigationBar: BottomNavigationBar(
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
//          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
//        ],
//        currentIndex: _selectedIndex,
//        fixedColor: Colors.blue,
//        onTap: _onItemTapped,
//      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: <Widget>[
            LabelIconButton(
              title: "今日任务",
              icon: Icon(Icons.alarm_on),
              onPressed: () {
                _onItemTapped(0);
              },
              color: _colorToday,
            ),
            LabelIconButton(
              title: "待办",
              icon: Icon(Icons.alarm),
              onPressed: () {
                _onItemTapped(1);
              },
              color: _colorTomorrow,
            ),
            SizedBox(),
            LabelIconButton(
              title: "历史记录",
              icon: Icon(Icons.history),
              onPressed: () {
                _onItemTapped(2);
              },
              color: _colorHistory,
            ),
            LabelIconButton(
              title: "我",
              icon: Icon(Icons.person),
              onPressed: () {
                _onItemTapped(3);
              },
              color: _colorMe,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.alarm_add),
        onPressed: _onPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bodyChanged(index) {
    Widget body;
    switch (index) {
      case 0:
        body = currentMissionWidget();
        break;
      case 1:
        body = pendingWidget();
        break;
      case 2:
        body = historyWidget();
        break;
      case 3:
        body = MinePage();
        break;
    }
    return body;
  }

  void _pageChanged(int index) {
    _index = index;
    _updateViewState(index);
  }

  /// * tab点击 * ///
  void _onItemTapped(int index) {
    _index = index;
    _pageController.animateToPage(index,
        duration: const Duration(microseconds: 300), curve: Curves.easeInOut);
    _updateViewState(index);
  }

  /// * 更新控件状态 * ///
  void _updateViewState(int index) {
    setState(() {
      switch (index) {
        case 0:
          _colorToday = Store.value<ThemeConfigModel>(context).theme;
          _colorTomorrow = Colors.grey;
          _colorHistory = Colors.grey;
          _colorMe = Colors.grey;
          break;
        case 1:
          _colorToday = Colors.grey;
          _colorTomorrow = Store.value<ThemeConfigModel>(context).theme;
          _colorHistory = Colors.grey;
          _colorMe = Colors.grey;
          break;
        case 2:
          _colorToday = Colors.grey;
          _colorTomorrow = Colors.grey;
          _colorHistory = Store.value<ThemeConfigModel>(context).theme;
          _colorMe = Colors.grey;
          break;
        case 3:
          _colorToday = Colors.grey;
          _colorTomorrow = Colors.grey;
          _colorHistory = Colors.grey;
          _colorMe = Store.value<ThemeConfigModel>(context).theme;
          break;
      }
    });
  }

  ///* 悬浮按钮点击
  void _onPressed() {
    setState(() {
      ToastUtil.showLongToast("敬请期待！");
    });
  }

  /// *** 今日任务  *** ////
  List curDatas = new List();
  List loadDatas = new List();
  int count = 0;
  int _curIndex = -1;

  Widget currentMissionWidget() {
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
          //显示单词列表项
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
                    color: Store.value<ThemeConfigModel>(context).theme,
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

  /// ****  待办事项  **** ////

  Widget pendingWidget() {
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

  /// ****  历史记录   **** ////

  Widget historyWidget() {
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
}
