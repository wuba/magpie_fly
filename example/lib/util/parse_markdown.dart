import 'dart:convert';
import 'package:flutter/services.dart';

//解析markdown工具
Future<List> parseMarkdown(String filepath) async {
  try {
    String content = await rootBundle.loadString(filepath);
    if(content.length == 0) return [];
    //根据换行符号截取字符串为数组
    List<String> list = content.split(RegExp(r'\r?\n'));

    List<dynamic> widgetlist = [];
    String markdown = '';
    for (var i = 0; i < list.length; i++) {
      String s = list[i];
      s = s.trim();
      if (s.startsWith('{{"demo":') && s.endsWith('}}')) {
        if (markdown.length > 0) widgetlist.add(markdown);
        markdown = '';
        String ss = s.substring(1, s.length - 1);
        Map map = json.decode(ss);
        var needAppBar = map['appbar'] ?? true;
        widgetlist.add(Model(demo: map['demo'],
            code: map['code'] ?? true,
            jump: map['jump'] ?? false,
            needAppbar: needAppBar));
      } else {
        markdown = markdown + '\n' + s;
      }
    }
    if (markdown.length > 0) widgetlist.add(markdown);
    return widgetlist;
  } catch (e) {
    print(e.toString());
    return null;
  }
}

class Model {
  String demo; //demo文件地址
  bool code = true;  //是否显示代码，默认显示
  bool jump = false;  //是否跳界面显示效果
  bool needAppbar = true;
  Model({this.demo, this.code = true, this.jump = false, this.needAppbar = true});

  bool get isJump => jump ?? false;

  String get className {
    String last = demo.split("/").last;
    if (last.endsWith('.dart')) {
      return last.substring(0, last.length - 5);
    }
    return last;
  }

  @override
  String toString() {
    return '{\"demo\": \"$demo\", \"code\": $code,\"jump\": $jump}';
  }
}

const String demoRegexp = '/^\"demo\": \"(.*)\"/';
bool isMatchDemo(String s) {
  RegExp demo = RegExp(demoRegexp);
  return demo.hasMatch(s);
}
