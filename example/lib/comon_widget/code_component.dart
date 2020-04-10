import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../util/syntax_highlighter.dart';

//代码和组件的组合控件

class CodeComponent extends StatefulWidget {
  final Widget component;
  final String codePath;

  CodeComponent({this.component, this.codePath});

  @override
  State<StatefulWidget> createState() {
    return _CodeComponentState();
  }
}

class _CodeComponentState extends State<CodeComponent> {
  bool _codeIsOpen = false;
  String _code = '';

  @override
  void initState() {
    super.initState();
    if (widget.codePath != null && widget.codePath.length > 0) {
      readCodeFile().then((code) {
        setState(() {
          _code = code ?? '';
        });
      });
    }
  }

  Future<String> readCodeFile() async {
    try {
      var a = await rootBundle.loadString(widget.codePath);
      return a;
    } catch (e) {
      print(e.toString());
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        widget.component==null?Text('') : widget.component,
        _code.length == 0 ? Text('') : _handleButttons(),
        _code.length == 0
            ? Text('')
            : Container(
                margin: EdgeInsets.symmetric(
                    vertical: _codeIsOpen == false ? 0 : 10),
                padding: EdgeInsets.all(_codeIsOpen == false ? 0 : 10),
                child: _codeIsOpen == false ? Text('') : _codeWidget(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color.fromRGBO(29, 30, 25, 1),
                ),
              )
      ],
    );
  }

  Widget _handleButttons() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(''),
        ),
        IconButton(
          icon: Icon(Icons.code),
          onPressed: () {
            setState(() {
              _codeIsOpen = !_codeIsOpen;
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.content_copy),
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: _code));
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('已复制到剪切板'),
              duration: Duration(milliseconds: 2000),
              backgroundColor: Colors.grey,
            ));
          },
        )
      ],
    );
  }

  Widget _codeWidget() {
    final SyntaxHighlighterStyle style =
        SyntaxHighlighterStyle.magpieDarkThemeStyle();
    Widget _codeWidget;
    try {
      DartSyntaxHighlighter(style).format(_code);
      _codeWidget = RichText(
        text: TextSpan(
          style: const TextStyle(fontFamily: 'monospace', fontSize: 16.0),
          children: <TextSpan>[DartSyntaxHighlighter(style).format(_code)],
        ),
      );
    } catch (err) {
      _codeWidget = Text(_code);
    }

    return Scrollbar(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: _codeWidget),
    );
  }
}
