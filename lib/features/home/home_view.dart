import 'package:flutter/material.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/home/widgets/chact_bot_view_body.dart';
import 'package:save_bite/features/home/widgets/custom_bottom_navigation_bar_iteam.dart';
import 'package:save_bite/features/home/widgets/home_view_body.dart';
import 'package:save_bite/features/home/widgets/more_view_body.dart';
import 'package:save_bite/features/home/widgets/stock_view_body.dart';
import 'package:save_bite/features/home/widgets/tracking_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeViewBody(),
    StockViewBody(),
    TrackingViewBody(),
    ChatBotViewBody(),
    MoreViewBody(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[currentIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            topLeft: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            onTap: onTabTapped,
            elevation: 0,
            currentIndex: currentIndex,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomNavigationBarIteam(
                  itemIndex: 0,
                  currentIndex: currentIndex,
                  image: Assets.imagesHome,
                  title: 'Home',
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomNavigationBarIteam(
                  itemIndex: 1,
                  currentIndex: currentIndex,
                  image: Assets.imagesStock,
                  title: 'Stock',
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomNavigationBarIteam(
                  itemIndex: 2,
                  currentIndex: currentIndex,
                  image: Assets.imagesTracking,
                  title: 'Tracking',
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomNavigationBarIteam(
                  itemIndex: 3,
                  currentIndex: currentIndex,
                  image: Assets.imagesChatBit,
                  title: 'ChatBite',
                ),
              ),
              BottomNavigationBarItem(
                label: '',
                icon: CustomBottomNavigationBarIteam(
                  itemIndex: 4,
                  currentIndex: currentIndex,
                  image: Assets.imagesMore,
                  title: 'More',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
