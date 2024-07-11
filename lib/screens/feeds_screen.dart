import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../services/api_handler.dart';
import '../widgets/feeds_widget.dart';
import '../widgets/listing_results_widget.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/search_form_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  State<FeedsScreen> createState() => _FeedsScreenState(location: this.location);
}

class _FeedsScreenState extends State<FeedsScreen> {

  _FeedsScreenState({required this.location});

  final String location;

  final ScrollController _scrollController = ScrollController();
  List<ProductsModel> productsList = [];
  int limit = 10;
  bool _isLoading = false;
  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // getProducts();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        print("_isLoading $_isLoading");
        limit += 10;
        await getProducts();
        _isLoading = false;
        print("limit $limit");
      }
    });
    super.didChangeDependencies();
  }

  Future<void> getProducts() async {
    productsList = await APIHandler.getAllProductsByLocation(location: location);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
      appBar: AppBar(
        title: Text('Properties in '+location),
      ),
      bottomNavigationBar: const NavBarMenu(pagename: 0),
      body: productsList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [


                  Padding(padding: const EdgeInsets.all(13.4),
                    child: SearchFormWidget(),
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productsList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0,
                              childAspectRatio: 0.8),
                      itemBuilder: (ctx, index) {
                        return ChangeNotifierProvider.value(
                            value: productsList[index],
                            child: const ListingResultsWidget());
                      }),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
    );
  }
}
