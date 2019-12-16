import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/SharedValuesModel.dart';
import 'package:flutter_app/page/CurrentMissionPage.dart';
import 'package:flutter_app/page/MinePage.dart';
import 'package:flutter_app/page/PendingPage.dart';
import 'package:flutter_app/utils/ToastUtil.dart';
import 'package:flutter_app/widget/LabelIconButton.dart';

import '../store/Index.dart';
import 'HistoryPage.dart';

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
        body = new CurrentMissionPage();
        break;
      case 1:
        body = new PendingPage();
        break;
      case 2:
        body = new HistoryPage();
        break;
      case 3:
        body = new MinePage();
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
          _colorToday = Store.value<SharedValuesModel>(context).theme;
          _colorTomorrow = Colors.grey;
          _colorHistory = Colors.grey;
          _colorMe = Colors.grey;
          break;
        case 1:
          _colorToday = Colors.grey;
          _colorTomorrow = Store.value<SharedValuesModel>(context).theme;
          _colorHistory = Colors.grey;
          _colorMe = Colors.grey;
          break;
        case 2:
          _colorToday = Colors.grey;
          _colorTomorrow = Colors.grey;
          _colorHistory = Store.value<SharedValuesModel>(context).theme;
          _colorMe = Colors.grey;
          break;
        case 3:
          _colorToday = Colors.grey;
          _colorTomorrow = Colors.grey;
          _colorHistory = Colors.grey;
          _colorMe = Store.value<SharedValuesModel>(context).theme;
          break;
      }
    });
  }

  ///* 悬浮按钮点击
  void _onPressed() {
    Navigator.pushNamed(context, "page_create_mission");
  }
}
