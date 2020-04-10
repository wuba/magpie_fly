import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/services.dart';

class MarkDownDoc extends StatelessWidget {
  final String mdPath;
  final String title;

  const MarkDownDoc({Key key, @required this.mdPath, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString(mdPath),
      builder: (context, data) {
        if (data.hasData) {
          return Scaffold(
            body: Markdown(
              data: data.data,
              onTapLink: (href) {
                _handleHref(context, href);
              },
              imageBuilder: (Uri uri){
                print(uri.path);
                try {
                  return Image.asset('doc/${uri.path}');
                } catch (e) {
                  return Text('');
                }
              },
            ),
            appBar: title != null
                ? AppBar(
                    title: Text(title),
                  )
                : null,
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("no md"),
            ),
          );
        }
      },
    );
  }

  /// 处理markdown点击事件
  _handleHref(BuildContext context, String href) {
    debugPrint(" ${href}");
    //其他跳转，可根据href区分title
    var title = "markdown";
    if(href.contains("how_to_add_compone")){
      title = "how to add compone";
    }else if(href.contains("magpie_ui")){
      title = "使用文档";
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MarkDownDoc(
                  mdPath: href,
                  title: title,
                )));
  }
}
