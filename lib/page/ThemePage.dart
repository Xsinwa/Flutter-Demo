import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/entity/ColorsModel.dart';
import 'package:flutter_app/store/Index.dart';
import 'package:flutter_app/entity/ThemeConfigModel.dart';
import 'package:flutter_app/utils/SharedPreferencesUtil.dart';

class ThemePage extends StatefulWidget{
  @override
  _ThemePageState createState() => _ThemePageState();
}
class _ThemePageState extends State<ThemePage> {
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
    for(int i=0; i < ColorsModel.colors.length; i++){
      _themeBox.add(GestureDetector(
        child: Container(
          color: ColorsModel.colors[i],
        ),
        onTap: (){
          Store.value<ThemeConfigModel>(context).setTheme(ColorsModel.colors[i]);
          SharedPreferencesUtil.set("theme", i);
        },
      ));
    }
  }
}