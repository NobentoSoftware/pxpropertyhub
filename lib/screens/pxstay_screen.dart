import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/navigation_bar.dart';

class PXStayScreen extends StatefulWidget {
   PXStayScreen({
    Key? key,
    required this.listing_category
  }) : super(key: key);

  final String listing_category;

  @override
  State<PXStayScreen> createState() => _PXStayScreenState();
}

class _PXStayScreenState extends State<PXStayScreen> {

  bool isLoading=true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: Text("Find Short Stays")),
        bottomNavigationBar: NavBarMenu(pagename: 1),
        body: Stack(
          children: <Widget>[
            WebView(
              //key: _key,
              initialUrl: "https://pxstay.com/",
              //initialUrl: "https://pxpropertyhub.com/view-listing?property_id="+widget.listing_category.toString(),
              userAgent: 'random',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (finish) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center( child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
    );
  }
}
