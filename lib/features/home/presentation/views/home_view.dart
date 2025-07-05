import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/home/domain/use_cases/add_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_product_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/get_stock_data_use_case.dart';
import 'package:save_bite/features/home/domain/use_cases/upload_products_use_case.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/manger/stock_data_cubit/stock_data_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_bottom_navigation_bar_iteam.dart';
import 'package:save_bite/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:save_bite/features/home/presentation/views/widgets/more_icon.dart';
import 'package:save_bite/features/home/presentation/views/widgets/more_view_body.dart';
import 'package:save_bite/features/home/presentation/views/widgets/tracking_view_body.dart';
import 'package:save_bite/injection_container.dart';

import '../../../ChatBot/presentation/pages/chatbot_page.dart';
import '../../../ChatBot/presentation/widgets/favourite_drawer.dart';
import '../../../Tracking/Presentation/pages/add_edit_product.dart';
import '../../../stock/presentation/pages/stock_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  bool isAddingOrEditing = false; // Track if in Add/Edit mode
  String? currentProductAction; // Track the action ("Add Product" or "Edit Product")

  late final List<Widget> pages; // Declare as late final

  @override
  void initState() {
    super.initState();
    pages = [
      HomeViewBody(),
      StockPage(),
      TrackingViewBody(onProductAction: _handleProductAction),
      ChatBotViewBody(),
      MoreViewBody(),
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      isAddingOrEditing = false; // Reset when switching tabs
      currentProductAction = null;
    });
  }

  void _handleProductAction(bool isEdit) {
    setState(() {
      isAddingOrEditing = true;
      currentProductAction = isEdit ? 'Edit Product' : 'Add Product';
    });
  }

  PreferredSizeWidget? _buildAppBar() {
    if (currentIndex == 2 && isAddingOrEditing && currentProductAction != null) {
      return AppBar(
        title: Text(
          currentProductAction!,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Sans',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xffCCCCCC))),
        toolbarHeight: 55,
      );
    } else if (currentIndex == 2) {
      return AppBar(
        title: Text(
          "Tracking",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Sans',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xffCCCCCC))),
        toolbarHeight: 55,
      );
    } else if (currentIndex == 1) {
      return AppBar(
        toolbarHeight: 55,
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Stock",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        shape: Border(bottom: BorderSide(color: Color(0xffCCCCCC))),
      );
    } else if (currentIndex == 3) {
      return AppBar(
        leading: FavoritesDrawer(),
        title: Text(
          "Chatbite",
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Sans',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xffCCCCCC))),
        toolbarHeight: 55,
      );
    } else if (currentIndex == 4) {
      return AppBar(title: Text("More"));
    }
    return null;
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
          appBar: _buildAppBar(),
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
              height: 84,
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