import 'package:flutter/material.dart';
import 'package:skg_hagen/src/common/service/tapAction.dart';
import 'package:skg_hagen/src/kindergarten/model/news.dart' as Model;
import 'package:skg_hagen/src/menu/controller/menu.dart';

class News extends StatelessWidget {
  final Model.News news;

  News({Key key, @required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mitteilung'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset('assets/images/kindergarten.jpg'),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                    child: Text(
                      news.title + ' - ' + news.getFormattedDate(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(news.content),
                  ),
                  Divider(),
                  _setLink(),
                ],
              ),
            ),
          );
        },
      ),
      drawer: Menu(),
    );
  }

  Widget _setLink() {
    if (this.news.linkText != null && this.news.link != null) {
      return InkWell(
        splashColor: Color(0xFF8EBC6B),
        onTap: () => TapAction().launchURL(this.news.link),
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            news.linkText,
            style: TextStyle(
                decoration: TextDecoration.underline, color: Colors.blue),
          ),
        ),
      );
    }
    return Container();
  }
}