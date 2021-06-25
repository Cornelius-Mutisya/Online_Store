import 'package:ecommerce/consts/theme_data.dart';
import 'package:ecommerce/inner_screens/brands_navigation_rail.dart';
import 'package:ecommerce/inner_screens/categories_feeds.dart';
import 'package:ecommerce/inner_screens/product_details.dart';
import 'package:ecommerce/provider/cart_provider.dart';
import 'package:ecommerce/provider/dark_theme_provider.dart';
import 'package:ecommerce/provider/favs_provider.dart';
import 'package:ecommerce/provider/products.dart';
import 'package:ecommerce/screens/auth/login.dart';
import 'package:ecommerce/screens/auth/sign_up.dart';
import 'package:ecommerce/screens/bottom_bar.dart';
import 'package:ecommerce/screens/cart.dart';
import 'package:ecommerce/screens/feeds.dart';
import 'package:ecommerce/screens/landing_page.dart';
import 'package:ecommerce/screens/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) {
        return themeChangeProvider;
      }),
      ChangeNotifierProvider(
        create: (_) => Products(),
      ),
      ChangeNotifierProvider(
        create: (_) => CartProvider(),
      ), 
      ChangeNotifierProvider(
        create: (_) => FavsProvider(),
      ),                                                                                                      
    ],
      child: Consumer<DarkThemeProvider>(builder: (context, themedata, child) {
        return MaterialApp(
          title: 'Duka',
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeChangeProvider.darkTheme, context),
          home: LandingPage(),

          //initialRoute: '/',
            routes: {
              //   '/': (ctx) => LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              Cart.routeName: (ctx) => Cart(),
              Feeds.routeName: (ctx) => Feeds(),
              Wishlist.routeName: (ctx) => Wishlist(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
              CategoriesFeeds.routeName: (ctx) => CategoriesFeeds(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
              BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
            },
        );
      }),
    );
  }
}
