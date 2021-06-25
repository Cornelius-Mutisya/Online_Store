import 'package:badges/badges.dart';
import 'package:ecommerce/consts/colors.dart';
import 'package:ecommerce/consts/my_icons.dart';
import 'package:ecommerce/models/product.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/favs_provider.dart';
import 'package:ecommerce/provider/products.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/wishlist.dart';
import 'package:ecommerce/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);
  static const routeName = '/Feeds';

  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as String?;
    final productsProvider = Provider.of<Products>(context);
    List<Product> productsList = productsProvider.products;
    if (popular == 'Popular') {
      productsList = productsProvider.popularProducts;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          'Feeds'
        ),
        actions: [
          Consumer<FavsProvider>(
                    builder: (_, favs, ch) => 
                    Badge(
                      badgeColor: ColorsConsts.favBadgeColor,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5, end: 7),
                      badgeContent: Text(
                        favs.getFavsItems.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        icon: Icon(
                          MyAppIcons.wishlist,
                          color: ColorsConsts.favColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(Wishlist.routeName);
                        },
                      ),
                  ),
                ),
                Consumer<CartProvider>(
                    builder: (_, cart, ch) => 
                    Badge(
                      badgeColor: ColorsConsts.cartBadgeColor,
                      animationType: BadgeAnimationType.slide,
                      toAnimate: true,
                      position: BadgePosition.topEnd(top: 5, end: 7),
                      badgeContent: Text(
                        cart.getCartItems.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    child: IconButton(
                      icon: Icon(
                        MyAppIcons.cart,
                        color: ColorsConsts.cartColor,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Cart.routeName);
                      },
                    ),
                  ),
                ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 440,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: List.generate(productsList.length, (index) {
          return ChangeNotifierProvider.value(
            value: productsList[index],
            child: FeedsProducts(),
          );
        }),
      ),
    );
  }
}
