import 'package:flutter/material.dart';

class CardWidget {
  static Widget card(Color cardBGColor) {
    var viewCount = '13450';
    return Container(
      width: 270,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: cardBGColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.5)),
                      color: Colors.black),
                  alignment: Alignment.center,
                  child: Text('#',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ),
                Text(' 活动', style: TextStyle(fontSize: 13)),
                Expanded(child: Text('')),
                Text('$viewCount人参与该话题',
                    style: TextStyle(fontSize: 12, color: Colors.black54)),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                '话题活动',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 15, bottom: 10),
              child: Text(
                '11月18日-12月22日，参与限时投票，票数多方瓜分逾10万元奖池。',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
