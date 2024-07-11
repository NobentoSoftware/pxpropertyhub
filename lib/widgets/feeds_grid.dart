import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import 'feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({Key? key, required this.productsList})
      : super(key: key);
  final List<ProductsModel> productsList;
  @override
  Widget build(BuildContext context) {
    int number_of_items = productsList.length;
    if(number_of_items > 4){
      number_of_items = 4;
    }
    return GridView.builder(

        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: number_of_items,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            childAspectRatio: 1.2),
        itemBuilder: (ctx, index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: const FeedsWidget(),
          );
        });
  }
}
