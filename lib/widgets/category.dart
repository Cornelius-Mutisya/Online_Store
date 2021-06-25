import 'package:ecommerce/inner_screens/categories_feeds.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  final List categories = [
    {
      'categoryName': 'Phones',
      'categoryImagePath': 'assets/images/CatPhones.png'
    },
    {
      'categoryName': 'Clothes',
      'categoryImagePath': 'assets/images/CatClothes.jpg'
    },
    {
      'categoryName': 'Shoes',
      'categoryImagePath': 'assets/images/CatShoes.jpg'
    },
    {
      'categoryName': 'Beauty&Health',
      'categoryImagePath': 'assets/images/CatBeauty.jpg'
    },
    {
      'categoryName': 'Laptops',
      'categoryImagePath': 'assets/images/CatLaptops.png'
    },
    {
      'categoryName': 'Furniture',
      'categoryImagePath': 'assets/images/CatFurniture.jpg'
    },
    {
      'categoryName': 'Watches',
      'categoryImagePath': 'assets/images/CatWatches.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(CategoriesFeeds.routeName, arguments: '${categories[index]['categoryName']}');
            
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                  image: AssetImage(categories[index]['categoryImagePath']),
                  fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: 150.0,
            height: 150.0,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ],
    );
  } 
}
