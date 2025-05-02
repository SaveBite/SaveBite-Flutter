import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/features/ChatBot/domain/entities/store_message.dart';
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

import '../../../ChatBot/presentation/bloc/chat_bloc/chat_bloc.dart';
import '../../../ChatBot/presentation/bloc/chat_bloc/chat_event.dart';
import '../../../ChatBot/presentation/bloc/favorite_messages_bloc/favorite_messages_bloc.dart';
import '../../../ChatBot/presentation/pages/chatbot_page.dart';
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

  void _showChatbotMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Favourite Recipes",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.75,
            heightFactor: 1.0,
            child: Material(
              color: Color(0xffF2F2F2),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: BlocProvider(
                  create: (context) => sl<FavoriteMessagesBloc>()
                    ..add(FetchFavoriteMessages()),
                  child: BlocBuilder<FavoriteMessagesBloc, FavoriteMessagesState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Favorites (${state is FavoriteMessagesLoaded ? state.messages.length : 0})",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Noto Sans',
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          if (state is FavoriteMessagesLoading)
                            Center(child: CircularProgressIndicator())
                          else if (state is FavoriteMessagesError)
                            Center(child: Text(state.message))
                          else if (state is FavoriteMessagesLoaded)
                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.messages.length,
                                  itemBuilder: (context, index) {
                                    final message = state.messages.toList()[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.grey[300],
                                        child: Icon(Icons.timer, size: 16),
                                      ),
                                      title: Text(
                                        message.message.length > 20
                                            ? '${message.message.substring(0, 20)}...'
                                            : message.message,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Noto Sans',
                                        ),
                                      ),
                                      subtitle: Text(
                                        "Ready in: 10 mins", // Adjust based on actual data
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onTap: () {
                                        final botMessage = StoreMessage(
                                          message: message.message,
                                          is_bot: true,
                                        );
                                        context.read<ChatBloc>().add(
                                          SendChatMessageEvent(botMessage),
                                        );
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                ),
                              )
                            else
                              Center(child: Text("No favorites yet")),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  PreferredSizeWidget? _buildAppBarForIndex(int index) {
    switch (index) {
      case 1:
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
      case 2:
        return AppBar(title: Text("Tracking"));
      case 3:
        return AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(Assets.imagesFavouriteMenu),
            onPressed: () => _showChatbotMenu(context),
          ),
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
      case 4:
        return AppBar(title: Text("More"));
      default:
        return null;
    }
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
          appBar: _buildAppBarForIndex(currentIndex),
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