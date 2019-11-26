import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Index.dart';
import 'package:flutter_app/entity/ThemeConfigModel.dart';

class ThemePage extends StatefulWidget{
  @override
  _ThemePageState createState() => _ThemePageState();
}
class _ThemePageState extends State<ThemePage> {

  List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.deepPurple,
    Colors.indigo,
    Colors.purple,
    Colors.deepOrange,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.lime,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
  ];
  //item列表
  List<GestureDetector> _themeBox = new List();

  @override
  void initState() {
    super.initState();
    _initItem(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("应用皮肤"),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.0
          ),
          itemBuilder: (context, index) {
            return _themeBox[index];
          },
        itemCount: _themeBox.length,
      ),
    );
  }

  void _initItem(BuildContext context){
    for(int i=0; i < colors.length; i++){
      _themeBox.add(GestureDetector(
        child: Container(
          color: colors[i],
        ),
        onTap: (){
          Store.value<ThemeConfigModel>(context).setTheme(colors[i]);
        },
      ));
    }
  }
}