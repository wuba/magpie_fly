import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class NewsPage extends StatefulWidget {
  String title;
  NewsPage(this.title);
  @override
  State<StatefulWidget> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  final _url = 'https://mp.weixin.qq.com/mp/homepage?__biz=MzI1NDc5MzIxMw==&hid=4&sn=4f1456867f1cabda91b4a7fecd147fa4&scene=18';
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool _showBackBtn = false;

  @override
  void initState() {
    flutterWebviewPlugin.onStateChanged.listen((viewState){
      if (viewState.type == WebViewState.finishLoad) {
        _changeShowBackBtn(); //判断是否显示返回按钮
        
      }
    });

    flutterWebviewPlugin.onBack.listen((_) {
      goBack();
    });
    super.initState();
    
  }

  void goBack() {
    flutterWebviewPlugin.goBack().then((onValue) {
      _changeShowBackBtn();
    });
  }

  //判断是否显示返回按钮
  void _changeShowBackBtn() {
    flutterWebviewPlugin.canGoBack().then((canGo) {
      setState(() {
        _showBackBtn = canGo;
        print(_showBackBtn);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: WebviewScaffold(
        url: _url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        hidden: true,
        withOverviewMode: true,
        useWideViewPort: true,
        appBar: AppBar(
          title: Text(widget.title ?? '58公众号'),
          leading: _showBackBtn
              ? new IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: goBack,
                )
              : null,
        ),
        initialChild: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
