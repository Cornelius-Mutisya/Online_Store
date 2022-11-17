import 'package:badges/badges.dart';
import 'package:ecommerce/inner_screens/product_details.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/widgets/feeds_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedsProducts extends StatefulWidget {
  const FeedsProducts({Key? key}) : super(key: key);

  @override
  _FeedsProductsState createState() => _FeedsProductsState();
}

class _FeedsProductsState extends State<FeedsProducts> {
  @override
  Widget build(BuildContext context) {
    final productsAttributes = Provider.of<Product>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productsAttributes.id),
        child: Container(
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  ClipRect(
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight: 120,
                        maxHeight: MediaQuery.of(context).size.height * 0.15,
                      ),
                      child: Image.network(
                        productsAttributes.imageUrl,
                        // fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Badge(
                      toAnimate: true,
                      animationDuration: Duration(milliseconds: 300),
                      animationType: BadgeAnimationType.fade,
                      shape: BadgeShape.square,
                      badgeColor: Colors.pink,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(8.0)),
                      position: BadgePosition.topEnd(top: 10, end: 10),
                      badgeContent: Text(
                        'New',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                margin: EdgeInsets.only(
                  left: 5,
                  bottom: 2,
                  right: 3,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      productsAttributes.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        '\$ ${productsAttributes.price}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items: ${productsAttributes.quantity}',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => FeedDialog(
                                      productId: productsAttributes.id));
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Icon(
                              Icons.more_horiz,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
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
