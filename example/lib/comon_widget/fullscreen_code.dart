import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/syntax_highlighter.dart';

class FullScreenCode extends StatelessWidget {
  final String code;

  const FullScreenCode({Key key, this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    final SyntaxHighlighterStyle style =
        Theme.of(context).brightness == Brightness.dark
            ? SyntaxHighlighterStyle.darkThemeStyle()
            : SyntaxHighlighterStyle.lightThemeStyle();
    Widget _codeWidget;
    try {
      DartSyntaxHighlighter(style).format(code);
      _codeWidget = RichText(
        text: TextSpan(
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12.0),
          children: <TextSpan>[DartSyntaxHighlighter(style).format(code)],
        ),
      );
    } catch (err) {
      _codeWidget = Text(code);
    }

    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Example Code"),
        actions: <Widget>[
          IconButton(
            tooltip: "copy",
            onPressed: () {
              Clipboard.setData(new ClipboardData(text: code));
              key.currentState.showSnackBar(
                  new SnackBar(content: new Text("已复制到粘贴板"),));
            },
            icon: Text("复制"),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _codeWidget,
        ),
      ),
    );
  }
}
