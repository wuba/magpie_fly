import 'dart:io';
// import 'package:args/args.dart';
import 'fileUtil.dart';


Future<void> main(List<String> arguments) async{

  // print('请输入Demo名称（限制英文，且数字不在第一位，如:test_widget）：');
  print('input your Demo name（eg:test_widget）：');
  String name = stdin.readLineSync() ?? 'test_widget';  
  print('');

  print('input you component title：');
  String title = stdin.readLineSync() ?? ''; 
  print('');


  print('input you component description：');
  String desc = stdin.readLineSync() ?? ''; 
  print('');

  print('您的demo在example/lib/demo/$name下，组件名称：$title，组件描述：$desc');

  var demoName = '$name';
  var className =  underScore2CamelCase(name);
  var demoPath = 'lib/demo/$demoName';
  var stateName = '_${className}State';
  await createFile('lib/demo');
  await createFile(demoPath);

  //创建.dart文件
  await writeContent2Path(demoPath, '${demoName}_demo.dart', 
  """
import 'package:flutter/material.dart';

class $className extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => $stateName();
}

class $stateName extends State<$className> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("this is flutter go init demo"),
    );
  }
}
  """);

//创建rm文件
  var rmName = '$demoName.md';
  await writeContent2Path(demoPath, rmName, 
  """
<!-- 这是只是一个例子 -->

## 简介
* 名称：你的组件名称
* 概述：你的组件概述
* 作者：你的邮箱

## 导入（安装）
  import 'package:magpie_ui/magpie_ui.dart';

## 概述
XXXXXXXXXXX

## 使用

<!-- 想在对应的地方加入自己的组件效果，需要嵌入固定格式代码，结构：{{"demo": "lib/demo/test/testdemo.dart", "code": true,  "jump": true}}

参数详解：
* demo：需要引入的样式的代码路径
* code：在样式下面是否显示对应的代码
* jump：该样式是否需要跳转界面显示（如果效果是全屏的效果，最好跳到下一页显示），不设置的话，会在这个地方显示自己的demo样式
 -->
效果：
{{"demo": "lib/demo/$demoName/${demoName}_demo.dart"}}

## 参数配置

| 参数 | 描述 |
| --- | --- |

  """
  );


//写json
  await writeContent2Path(demoPath, '.page.json', 
  """
  {
    "name": "$name",
    "title": "$title",
    "desc": "$desc",
    "markdown": "$demoPath/$rmName"
  }
  """
  );

//写列表数据
  buildList().then((list){
    writeContent2Path('lib/demo', 'ListDatas.dart', 
    """
    //列表页数据

    List<Map<String, String>> DemolistDatas = $list;
    """
    );
  });

}

Future<List> buildList() async {
  var demoPath = 'lib/demo/';
  var directory = Directory(demoPath);
  List<FileSystemEntity> files = directory.listSync();

  List list = [];
  for (var file in files) {
    var isdir = FileSystemEntity.isDirectorySync(file.path);
    //文件夹
    if(isdir){
      var subdirectory = Directory(file.path);
      List<FileSystemEntity> subfiles = subdirectory.listSync();
      for (var subFile in subfiles) {
        //取出md文件
        if(FileSystemEntity.isFileSync(subFile.path) && subFile.path.endsWith('.page.json')){
          var file = File(subFile.path);
          try {
             String jsonstring = file.readAsStringSync();
             list.add(jsonstring);
          } catch (e) {
            print(e.toString());
          }
          break;
        }
      }
    }
  }
  return list;
}

String underScore2CamelCase(String key) {
  RegExp regex = new RegExp(r'[_]+(.)');
  String s = key.replaceAllMapped(regex, (m) {
    return m.group(1).toUpperCase();
  });
  return '${s[0].toUpperCase()}${s.substring(1)}';
}


