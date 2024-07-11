import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/navigation_bar.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isLoading=true;
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Support")),
      bottomNavigationBar: const NavBarMenu(pagename: 2),
      body: Stack(
        children: <Widget>[
          WebView(
            //key: _key,
            initialUrl: "https://pxpropertyhub.com/contact-support",
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
