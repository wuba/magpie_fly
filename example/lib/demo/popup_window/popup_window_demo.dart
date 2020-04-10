import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magpie_fly/magpie_fly.dart';

class PopupWindowTest extends StatelessWidget {
  GlobalKey gk1 = new GlobalKey();
  GlobalKey gk2 = new GlobalKey();
  GlobalKey gk3 = new GlobalKey();

  List cityData = [
    "北京",
    "上海",
    "广州",
    "深圳",
    "天津",
    "成都",
    "苏州",
    "重庆",
    "武汉",
    "长沙",
    "青岛"
  ];

  @override
  Widget build(BuildContext context) {
    var content = Column(
      children: <Widget>[
        Container(
          child: SizedBox(
            key: gk1,
            height: 40,
            child: FlatButton(
                onPressed: () {
                  PopupWindow.showPopWindow(
                      context, gk1, PopDirection.left, FlutterLogo(), 5);
                },
                child: Text(
                  "左侧图片",
                  style: TextStyle(color: Colors.black54),
                )),
          ),
          width: 200,
          height: 50,
          decoration: BoxDecoration(color: Colors.deepOrange),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        ),
        Container(
          child: SizedBox(
            key: gk2,
            height: 40,
            child: FlatButton(
                onPressed: () {
                  PopupWindow.showPopWindow(
                      context,
                      gk2,
                      PopDirection.bottom,
                      Container(
                        width: 100.0,
                        height: 200.0,
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(1))),
                        child: Scaffold(
                          body: Container(
                            child: ListView.builder(
                              itemCount: cityData.length,
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              itemBuilder:
                                  (BuildContext context, int position) {
                                String str = cityData[position];
                                return FlatButton(
                                  child: Text(str,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 20)),
                                  onPressed: () {
                                    Navigator.pop(context);

                                    Fluttertoast.showToast(
                                        msg: str + "onClick",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.white70,
                                        textColor: Colors.black54,
                                        fontSize: 12.0);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      0);
                },
                child: Text(
                  "下方城市列表",
                  style: TextStyle(color: Colors.black54),
                )),
          ),
          width: 200,
          height: 50,
          decoration: BoxDecoration(color: Colors.deepOrange),
          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        ),
      ],
    );
    return Column(
      children: <Widget>[content],
    );
  }
}
