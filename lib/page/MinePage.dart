import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget{

   @override
  _MinePageState createState() {
    return new _MinePageState();
  }
}

class _MinePageState extends State<MinePage> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints:
            BoxConstraints.tightFor(width: double.infinity, height: 180),
            child: Stack(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.tightFor(
                      width: double.infinity, height: 180),
                  decoration: BoxDecoration(
                    //背景装饰
                    gradient: RadialGradient(
                      //径向渐变
                      colors: [
                        Colors.purple,
                        Colors.deepPurple,
                        Colors.deepPurpleAccent,
                      ],
                      radius: 5,
                      center: Alignment.topLeft,
                    ),
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 15,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
                    ),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 110,
                  child: Text(
                    "Xsinwa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Positioned(
                  top: 122,
                  left: 110,
                  child: Text(
                    "今日事今日毕",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
//          Container(
//            constraints:
//                BoxConstraints.tightFor(width: double.infinity, height: 5),
//            color: Colors.black12,
//          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
            child: Container(
              constraints:
              BoxConstraints.tightFor(width: double.infinity, height: 50),
              child: GestureDetector(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("设置"),
                    ),
                    Icon(Icons.chevron_right, color: Colors.black12,)
                  ],
                ),
                onTap: (){
                  Navigator.pushNamed(context, "page_setting");
                },
              ),
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

  @override
  bool get wantKeepAlive => true;
}