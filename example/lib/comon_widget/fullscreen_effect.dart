import 'fullscreen_code.dart';
import '../util/config.dart';
import '../util/parse_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FullScreenEffect extends StatelessWidget {
  final Model model;

  const FullScreenEffect({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [
      IconButton(
        tooltip: "source",
        onPressed: () {
          rootBundle.loadString(model.demo).then((value) {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => FullScreenCode(code: value)));
          });
        },
        icon: Icon(Icons.code),
      )
    ];

    if (model.needAppbar) {
      return Scaffold(
        appBar: AppBar(
          title: Text(model.className),
          actions: actions,
        ),
        body: Container(
          alignment: Alignment.center,
          child: markdownPathToWidget[model.demo](),
        ),
      );
    }
    return markdownPathToWidget[model.demo]();
  }
}
