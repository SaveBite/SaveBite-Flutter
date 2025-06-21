import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/widgets/loading_widget.dart';
import 'package:save_bite/features/ChatBot/domain/entities/store_message.dart';

import 'package:save_bite/injection_container.dart';

import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/chat_bloc/chat_event.dart';
import '../bloc/favorite_messages_bloc/favorite_messages_bloc.dart';

class FavoritesDrawer extends StatelessWidget {
  const FavoritesDrawer({super.key});

  String extractPrepTime(String message) {
    try {
      if (message.contains("Time") && message.contains("Ingredients")) {
        return message.split("Time")[1].split("Ingredients")[0].trim();
      }
      return "Prep time not found";
    } catch (e) {
      return "Error extracting prep time";
    }
  }

  String extractMessage(String rawText) {
    try {
      final lines = rawText.trim().split('\n');
      String firstLine = lines.isNotEmpty ? lines[0] : "No title found";
      if (firstLine.toLowerCase().startsWith("message:")) {
        firstLine = firstLine.split("message:")[1].trim();
      }
      return firstLine;
    } catch (e) {
      return "Error extracting message";
    }
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
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Noto Sans',
                                  color: Colors.black
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                          Divider(),
                          if (state is FavoriteMessagesLoading)
                            Center(child: LoadingWidget())
                          else if (state is FavoriteMessagesError)
                            Center(child: Text(state.message))
                          else if (state is FavoriteMessagesLoaded)

                              Expanded(
                                child: ListView.builder(
                                  itemCount: state.messages.length,
                                  itemBuilder: (context, index) {
                                    final message = state.messages.toList()[index];
                                    return Card(
                                      color:Colors.white,
                                      margin: EdgeInsets.all(2),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),side: BorderSide(color: Color(0xffCCCCCC))),
                                      child: ListTile(
                                        title: Text(
                                          extractMessage(message.message),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff333333),
                                            fontFamily: 'Noto Sans',
                                          ),
                                        ),
                                        subtitle: Text(
                                          "⏰ Ready in${extractPrepTime(message.message)}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          alignment: Alignment.topRight,
                                          iconSize: 18,
                                          padding: EdgeInsets.all(8),
                                          icon: Icon(
                                            message.favourite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: message.favourite ? Colors.red : null,
                                          ),
                                          onPressed: message.id <= 0
                                              ? null
                                              : () {
                                            context.read<ChatBloc>().add(
                                              ToggleFavoriteEvent(
                                                  message.id, !message.favourite),
                                            );
                                            context
                                                .read<FavoriteMessagesBloc>()
                                                .add(FetchFavoriteMessages());
                                          },
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
                                      ),
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(Assets.imagesFavouriteMenu),
      onPressed: () => _showChatbotMenu(context),
    );
  }
}