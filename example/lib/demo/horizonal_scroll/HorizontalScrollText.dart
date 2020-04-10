import 'package:flutter/material.dart';
import 'package:magpie_fly/magpie_fly.dart';
import 'package:magpie_fly_example/demo/horizonal_scroll/component/card.dart';

// import 'component/card.dart';


class HorizontalScrollText extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: HorizontalScrollView(
            itemCount: 10,
            footerWidth: 70,
            onFooterLoadingCallBack: (){
              print('开始加载');
            },
            footerView: FooterTextView(height: 150),
            footerShowStyle: FooterViewShowStyle.dismiss,
            footViewFlowScrollAlways: true,
            itembuilder: (context, index){
              return CardWidget.card(Color.fromRGBO(233, 248, 244, 1));
            },
          ),
    );
  }
}