import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skg_hagen/src/common/model/default.dart';
import 'package:skg_hagen/src/common/model/sizeConfig.dart';
import 'package:skg_hagen/src/common/view/customWidget.dart';
import 'package:skg_hagen/src/offer/model/offers.dart';
import 'package:skg_hagen/src/offer/model/quote.dart' as Model;

class Quote extends StatelessWidget {
  final List<Model.Quote> quote;
  final BuildContext context;
  final bool dataAvailable;

  const Quote(
      {Key key, this.context, @required this.quote, this.dataAvailable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              pinned: true,
              expandedHeight: SizeConfig.getSafeBlockVerticalBy(20),
              backgroundColor: Color(Default.COLOR_GREEN),
              flexibleSpace: FlexibleSpaceBar(
                title: CustomWidget.getTitle(Model.Quote.PAGE_NAME),
                background: Image.asset(
                  Offers.IMAGE,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => dataAvailable
                    ? _buildRows(this.quote[index], context)
                    : CustomWidget.buildSliverSpinner(),
                childCount: quote?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          !dataAvailable ? CustomWidget.noInternet() : Container(),
        ],
      ),
    );
  }

  Widget _buildRows(Model.Quote quote, BuildContext context) {
    return Material(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: SizeConfig.getSafeBlockHorizontalBy(0),
        ),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            CustomWidget.getSlidableShare(
              Model.Quote.PAGE_NAME,
              Default.getSharableContent(quote.getText()),
            )
          ],
          child: Card(
            shape: Border(
              left: BorderSide(
                color: Color(Default.COLOR_GREEN),
                width: SizeConfig.getSafeBlockHorizontalBy(1),
              ),
            ),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.getSafeBlockVerticalBy(2),
                    ),
                    child: Text(
                      quote.text,
                      style: TextStyle(
                        fontSize: SizeConfig.getSafeBlockVerticalBy(
                            Default.STANDARD_FONT_SIZE),
                      ),
                    ),
                  ),
                  subtitle: (quote.getBook().length > 1)
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.getSafeBlockVerticalBy(1),
                            bottom: SizeConfig.getSafeBlockVerticalBy(2),
                          ),
                          child: Text(
                            quote.getBook(),
                            style: TextStyle(
                              fontSize: SizeConfig.getSafeBlockVerticalBy(
                                  Default.SUBSTANDARD_FONT_SIZE),
                            ),
                          ),
                        )
                      : Text(''),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
