import 'package:ecommerce/provider/products.dart';
import 'package:ecommerce/widgets/feeds_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesFeeds extends StatelessWidget {
  const CategoriesFeeds({Key? key}) : super(key: key);

  static const routeName = '/CategoriesFeeds';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context)!.settings.arguments as String?;
    print(categoryName);
    final productsList = productsProvider.findByCategory(categoryName!);
    return Scaffold(
      body: productsList.length == 0
          ? Center(
              child: Text('No Products in this Category'),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: List.generate(productsList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: FeedsProducts(),
                );
              }),
            ),
//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
    );
  }
}
