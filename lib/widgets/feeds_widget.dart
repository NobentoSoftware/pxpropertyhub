import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../models/products_model.dart';
import '../consts/api_consts.dart';
import '../screens/pxproperty_screen.dart';
import '../screens/pxstay_screen.dart';

class FeedsWidget extends StatelessWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsModelProvider = Provider.of<ProductsModel>(context);

    return Scaffold(
      body: Column(
        children: [
          InkWell(

      child: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage("https://"+BASE_URL+"/"+productsModelProvider.images![0]))),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      productsModelProvider.category!.name.toString()+" Properties",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blueAccent,
                        background: Paint()..color = Colors.white
                          ..strokeWidth = 30
                          ..style = PaintingStyle.stroke,
                      ),
                    )
                ),
              ),
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: PXPropertyScreen(listing_category: productsModelProvider.reference.toString()),
                ),
              );
            },
          ),

        ],
      ),
    );
  }
}
