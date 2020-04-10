// import '../../comon_widget/fullscreen_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magpie_fly/magpie_fly.dart';
import 'package:magpie_fly_example/comon_widget/fullscreen_code.dart';

import 'component/simple_rect.dart';

class PinnedSliverDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<PinnedSliverDemo> {
  final _tabs = ['Hot', 'Latest', 'Friends'];

  @override
  Widget build(BuildContext context) {
    var pinnedColor = Colors.blue[800];
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: pinnedBuilder(
              placeHolderSize: 100,
              color: pinnedColor,
              height: 200,
              headerBuilder: (context) {
                return Container(
                  height: 200,
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  child: CustomRect(),
                );
              },
              builder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  PinnedAppBar(
                    color: pinnedColor,
                    child: TabBar(
                        labelColor: Colors.white,
                        indicatorColor: Colors.white,
                        indicatorWeight: 4,
                        tabs: _tabs
                            .map((String name) => Tab(text: name))
                            .toList()),
                  )
                ];
              }),
          body: TabBarView(
            children: _tabs
                .map((name) => ListView.separated(
                    itemBuilder: (_, j) => Text("$name message #$j"),
                    separatorBuilder: (_, index) => Divider(),
                    itemCount: 30))
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          rootBundle
              .loadString('lib/demo/pinned_sliver/pinned_sliver_demo.dart')
              .then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullScreenCode(code: value)));
          });
        },
        tooltip: "source",
        child: Icon(Icons.code),
      ),
    );
  }
}
