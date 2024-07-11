import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import '../../screens/pxproperty_screen.dart';
import '../../services/api_handler.dart';

import '../models/locations_model.dart';
import '../models/products_model.dart';
import '../widgets/appbar_icons.dart';
import '../widgets/feeds_grid.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/search_form_widget.dart';
import 'chat_screen.dart';
import 'feeds_screen.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _textEditingController;

  static const IconData chat_bubble_2_fill = IconData(0xf8bd, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData search = IconData(0xf4a5, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage);

  int selectedTap = 0;

  bool _switch =  false;
  ThemeData _dark = ThemeData(brightness: Brightness.dark);
  ThemeData _light = ThemeData(brightness: Brightness.light);
  bool isChangeColor = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
    _getLocationsAutocomplete();
  }

  LocationsModel? locationsModel;

  void _getLocationsAutocomplete()async{
    var response = await http.get(Uri.parse("https://pxpropertyhub.com/api/v1/locations"));
    //print(response.body);
    setState(() {
      locationsModel = LocationsModel.fromJson(json.decode(response.body));
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: _switch ? _dark : _light,

      home: Scaffold(
          appBar: AppBar(
            backgroundColor: isChangeColor ? Colors.black12 : Colors.white,
            // elevation: 4,
            //title: const Text('Home'),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0))
              ],
            ),
            leading: AppBarIcons(

              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: ChatScreen(),
                  ),
                );
              },
              icon: chat_bubble_2_fill,
            ),
            actions: [
              Switch(value: _switch, onChanged: (_newvalue){
                setState((){
                  _switch = _newvalue;
                  isChangeColor = _switch;
                });
              }),
              // Container(
              //     margin: EdgeInsets.only(left: 1.0, right: 20.0, top: 17.0),
              //     child: Text("Dark",
              //       style: TextStyle(
              //         fontWeight: FontWeight.w700,
              //         fontSize: 18,
              //         color: Colors.blueAccent
              //       ),
              //     ),
              // )
            ],
          ),
          //const SearchFormWidget();
          bottomNavigationBar: const NavBarMenu(pagename: 0),
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Expanded(

                  child: SingleChildScrollView(

                    child: Column(children: [
                      Container(
                        //width: 100,
                          height: size.height * 0.35,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: ExactAssetImage('assets/images/mobile-banner.gif'),
                              fit: BoxFit.fitHeight,
                            ),
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.35,
                        child: Swiper(
                          itemCount: 3,
                          itemBuilder: (ctx, index) {
                            String slider_text = "Residentials";
                            String slider_image = "assets/images/mobile-residential-property.png";
                            if(index == 1){
                              slider_text = "Commercial";
                              slider_image = "assets/images/mobile-commercial-property.png";
                            }
                            if(index == 2){
                              slider_text = "Industrial";
                              slider_image = "assets/images/mobile-retail-property.png";
                            }
                            return Container(
                              width: double.infinity,
                              height: size.height * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                // gradient: const LinearGradient(
                                //     colors: [
                                //       Color(0xFF7A60A5),
                                //       Color(0xFF82C3DF),
                                //     ],
                                //     begin: FractionalOffset(0.0, 0.0),
                                //     end: FractionalOffset(1.0, 0.0),
                                //     stops: [0.0, 1.0],
                                //     tileMode: TileMode.clamp),
                              ),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Image.asset(
                                        width: double.infinity,
                                        // height: double.infinity,
                                        slider_image,
                                        fit: BoxFit.contain,
                                      ),

                                    ),
                                  ),

                                ],
                               // Text("hello"),
                              ),

                            );
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.blueAccent)),
                          // control: const SwiperControl(),

                        ),

                      ),
                      Padding(padding: const EdgeInsets.all(8.0),),

                      Column(
                        children: const [

                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Find Property Listings In Your Area.",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                //backgroundColor: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Padding(padding: const EdgeInsets.all(13.4),
                        child: SearchFormWidget(),
                      ),

                      Padding(padding: const EdgeInsets.only(
                        top: 2.0,
                        left: 25.0
                      ),
                        child: Column(
                          children:  [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: RichText(
                                text: TextSpan(
                                  style: new TextStyle(color: Colors.blue),
                                  children: <TextSpan>[

                                    TextSpan(
                                        text: 'Advanced Search',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          //backgroundColor: Colors.blueAccent,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: const PXPropertyScreen(listing_category: "home"),
                                              ),
                                            );
                                          }),

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),



                      Padding(padding: const EdgeInsets.all(8.0),),
                      //const Spacer(),
                      FutureBuilder<List<ProductsModel>>(
                          future: APIHandler.getAllProducts(limit: "4"),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapshot.hasError) {
                              Center(
                                child:
                                    Text("An error occured ${snapshot.error}"),
                              );
                            } else if (snapshot.data == null) {
                              const Center(
                                child: Text("No products has been added yet"),
                              );
                            }
                            if(snapshot.data == null){
                              return Text("No Listings added in yout area as yet.");
                            }else{
                              return FeedsGridWidget(productsList: snapshot.data!);
                            }
                            print(snapshot.data);
                          }))
                    ]),
                  ),
                )
              ],
            ),
          )),

    );
  }
}
