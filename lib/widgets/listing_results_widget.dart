import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../consts/api_consts.dart';
import '../models/products_model.dart';
import '../screens/pxproperty_view_property_screen.dart';

class ListingResultsWidget extends StatelessWidget {
  const ListingResultsWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    final productsModelProvider = Provider.of<ProductsModel>(context);
    var formatter = NumberFormat('#,##,000');
    int? property_price = productsModelProvider.price;
    String price_text = "Contact Agent For Price";
    if(property_price !< 0){
      property_price = 0;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: PXPropertyViewPropertyScreen(listing_category: productsModelProvider.reference.toString()),
          ),
        );
      },
      child: GFCard(
        boxFit: BoxFit.cover,
        titlePosition: GFPosition.start,
        image: Image.network("https://"+BASE_URL+"/"+productsModelProvider.images![0],
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        showImage: true,
        title: GFListTile(
          titleText: productsModelProvider.title,
          subTitleText: productsModelProvider.category!.name.toString(),
        ),
        content: Text(productsModelProvider.currency.toString()+""+formatter.format(property_price),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 25,
            color: GFColors.PRIMARY,
          ),
        ),
      ),
    );

  }
}