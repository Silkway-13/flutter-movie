import 'package:flutter/material.dart';
import 'package:movieapp/providers/common.dart';
import 'package:movieapp/screens/movies.dart';
import 'package:movieapp/screens/profile.dart';
import 'package:movieapp/screens/wishlist.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> _totalPage = [
    MoviesPage(),
    WishListPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CommonProvider>(
      builder: ((context, provider, child) {
        return Scaffold(
          backgroundColor: Color(0xff36393f),
          body: SafeArea(
            child: _totalPage[provider.currentIdx],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: provider.currentIdx,
            onTap: provider.changeCurrentIdx,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: "movie".tr(),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "favorite".tr(),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.person),
                label: "profile".tr(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
