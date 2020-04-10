import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'markdown_doc.dart';
import 'package:flutter/material.dart';
import 'news.dart';
import 'list.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppPageState();
}

class AppPageState extends State<AppPage> {
  //数据
  static List tabDatas = [
    {'title': '58公众号', 'icon':Image.asset('assets/images/tab_nomal1.png'), 'selectIcon':Image.asset('assets/images/tab_selected1.png')},
    {'title': 'Widget', 'icon':Image.asset('assets/images/tab_nomal2.png'), 'selectIcon':Image.asset('assets/images/tab_selected2.png')},
    {'title': '使用文档', 'icon':Image.asset('assets/images/tab_nomal3.png'), 'selectIcon':Image.asset('assets/images/tab_selected3.png')},
    {'title': '贡献流程', 'icon':Image.asset('assets/images/tab_nomal4.png'), 'selectIcon':Image.asset('assets/images/tab_selected4.png')},
  ];

  List<Widget> _pages = List();
  List<BottomNavigationBarItem> _tabs = [];
  var _currentIndex = 0;
  var _currentTitle = tabDatas[0]['title'];
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  
  @override
  void initState() {
    super.initState();

    //页面列表
    _pages..add(NewsPage(_currentTitle))..add(ListPage())..add(MarkDownDoc(mdPath: 'doc/magpie_ui.md',))..add(MarkDownDoc(mdPath: 'doc/contribution.md',));

    //tab列表
    tabDatas.forEach((map) {
      _tabs.add(BottomNavigationBarItem(
        title: Text(map['title'], style: TextStyle(fontSize: 10),),
        icon:map['icon'],
        activeIcon: map['selectIcon']
      ));
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex==0?null:AppBar(title: Text(_currentTitle)),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabs,
        currentIndex: _currentIndex,
        onTap: tabClick,
        type: BottomNavigationBarType.fixed,
        selectedFontSize:16,
        unselectedFontSize: 14,
      ),
    );
  }

  void tabClick(int index) {
    setState(() {
      _currentIndex = index;
      _currentTitle = tabDatas[index]['title'];
      if(_currentIndex != 0){
        flutterWebviewPlugin.hide();
      }else{
        flutterWebviewPlugin.show();
      }
    });
  }
}