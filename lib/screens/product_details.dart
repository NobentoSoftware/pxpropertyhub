import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../models/products_model.dart';
import '../../services/api_handler.dart';

import '../consts/api_consts.dart';
import '../consts/global_colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
    required this.listing_category,
  }) : super(key: key);
  final String id;
  final String listing_category;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  ProductsModel? productsModel;
  bool isError = false;
  String errorStr = "";
  Future<void> getProductInfo() async {
    try {
      productsModel = await APIHandler.getProductById(id: widget.id);
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProductInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String page_title = widget.listing_category.toString();//"Listing Details";

    return Scaffold(
      appBar: AppBar(
        // elevation: 4,
        title: Text(page_title),
      ),
      body: SafeArea(
        child: isError
            ? Center(
                child: Text(
                  "An error occured $errorStr",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              )
            : productsModel == null
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 18,
                        ),
                        //const BackButton(),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 18,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Text(
                                      productsModel!.title.toString(),
                                      textAlign: TextAlign.start,
                                      style: titleStyle,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: RichText(
                                      text: TextSpan(
                                          text: productsModel!.currency.toString(),
                                          style: const TextStyle(
                                              fontSize: 25,
                                              color: Color.fromRGBO(
                                                  33, 150, 243, 1)),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: productsModel!.price
                                                    .toString(),
                                                style: TextStyle(
                                                    color: lightTextColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.4,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return FancyShimmerImage(
                                width: double.infinity,
                                imageUrl:
                                "https://"+BASE_URL+"/"+productsModel!.images![index].toString(),
                                boxFit: BoxFit.fill,
                              );
                            },

                            autoplay: true,
                            itemCount: productsModel!.images!.length, //number of images on the listing
                            pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              builder: DotSwiperPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.red,
                              ),
                            ),
                            // control: const SwiperControl(),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description', style: titleStyle),
                              const SizedBox(
                                height: 18,
                              ),
                              Text(
                                productsModel!.description.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
