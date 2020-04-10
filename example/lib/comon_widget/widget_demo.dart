/// @author Nealyang
/// 新widget详情页模板

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class WidgetDemo extends StatefulWidget {
  final List<dynamic> contentList;
  final String docUrl;
  final String codeUrl;
  final Widget bottomNaviBar;

  WidgetDemo(
      {Key key,
      @required this.contentList,
      this.codeUrl,
      this.docUrl,
      this.bottomNaviBar})
      : super(key: key);

  _WidgetDemoState createState() => _WidgetDemoState();
}

class _WidgetDemoState extends State<WidgetDemo> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> _buildContent() {
    List<Widget> _list = [
      SizedBox(
        height: 10.0,
      ),
    ];
    widget.contentList.forEach((item) {
      if (item.runtimeType == String) {
        _list.add(Container(alignment: Alignment.centerLeft, child: MarkdownBody(data: item)));
        _list.add(
          SizedBox(
            height: 20.0,
          ),
        );
      } else {
        _list.add(item);
      }
    });
    return _list;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          Column(
            children: _buildContent(),
          ),
        ],
      ),
    );
  }
}
