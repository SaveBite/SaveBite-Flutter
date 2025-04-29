import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/chact_bot_view_body.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_bottom_navigation_bar_iteam.dart';
import 'package:save_bite/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:save_bite/features/home/presentation/views/widgets/more_icon.dart';
import 'package:save_bite/features/home/presentation/views/widgets/more_view_body.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tracking_view_body.dart';
import 'package:save_bite/injection_container.dart';

import '../../../stock/presentation/pages/stock_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeViewBody(),
    StockPage(),
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(
            sl<GetProductUseCase>(),
            sl<UploadProductsUseCase>(),
            sl<AddProductUseCase>(),
          ),
        ),
        BlocProvider(
          create: (context) => StockDataCubit(
            sl<GetStockDataUseCase>(),
          ),
        ),
      ],
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
            child: SizedBox(
              height: 90,
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
                      image: Assets.imagesChatBite,
                      title: 'ChatBite',
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: '',
                    icon: MoreIcon(
                      currentIndex: currentIndex,
                      itemIndex: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
