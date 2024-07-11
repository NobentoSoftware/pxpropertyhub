import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/navigation_bar.dart';

class PXPropertyScreen extends StatefulWidget {

  const PXPropertyScreen({Key? key,required this.listing_category}) : super(key: key);
  final String listing_category;
  @override
  State<PXPropertyScreen> createState() => _PXPropertyScreenState();
}

class _PXPropertyScreenState extends State<PXPropertyScreen> {
  bool isLoading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Property Listings")),
        bottomNavigationBar: const NavBarMenu(pagename: 2),
      body: Stack(
        children: <Widget>[
          WebView(
            //key: _key,
            //initialUrl: "https://pxpropertyhub.com/",
            initialUrl: "https://pxpropertyhub.com/view-listing?property_id="+widget.listing_category.toString(),
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
