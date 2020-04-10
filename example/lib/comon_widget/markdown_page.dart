import 'effect_placeholder.dart';
import '../util/config.dart';
import '../util/parse_markdown.dart';
import 'package:flutter/material.dart';
import 'code_component.dart';
import 'widget_demo.dart';

class MarkdownPage extends StatefulWidget {
  MarkdownPage({@required this.filePath});

  final String filePath;

  @override
  State<StatefulWidget> createState() {
    return _MarkdownPageState();
  }
}

class _MarkdownPageState extends State<MarkdownPage> {
  List _contentList = [];
  bool _loadMarkdownError = false;

  @override
  void initState() {
    super.initState();
    parseMarkdown(widget.filePath).then((List list) {
      if (list == null) {
        _loadMarkdownError = true;
      } else {
        _loadMarkdownError = false;
        for (var item in list) {
          if (item is String) {
            _contentList.add(item);
          } else if (item is Model && markdownPathToWidget[item.demo] != null) {
            if(!item.isJump){
              Widget wid = parseContentWidget(item);
              _contentList.add(wid);
            }else{
              _contentList.add(EffectPlaceHolder(model: item));
            }
          }
        }
      }
      setState(() {});
    });
  }

  Widget parseContentWidget(Model model) {
    try {
      Widget w = markdownPathToWidget[model.demo]();
      return CodeComponent(component: w, codePath: (model.code!=null&&model.code==true)?model.demo:null);
    } catch (e) {
      print('parseContentWidget : ${e.toString()}');
    }
    return Text('');
  }

  @override
  Widget build(BuildContext context) {
    return WidgetDemo(
      contentList: _loadMarkdownError?[Text('请在pubspec.yaml中配置assets \n${widget.filePath}')]:_contentList,
    );
  }
}
