import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_assets.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/chat_bloc/chat_event.dart';
import '../bloc/chat_bloc/chat_state.dart';
import '../bloc/recipe_bloc/recipe_bloc.dart';
import '../bloc/recipe_bloc/recipe_state.dart';
import '../widgets/chat_input_field.dart';
import '../widgets/recipe_card.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/entities/store_message.dart';
import '../../domain/entities/store_message_response.dart';

class ChatScreen extends StatelessWidget {
  final List<StoreMessageResponse> messages;
  final TextEditingController controller;
  final ScrollController scrollController;
  final void Function(String) onSend;
  final void Function(StoreMessageResponse) onNewMessage;
  final void Function(String) onError;
  final void Function(int, bool)? onFavoriteToggled;

  const ChatScreen({
    super.key,
    required this.messages,
    required this.controller,
    required this.scrollController,
    required this.onSend,
    required this.onNewMessage,
    required this.onError,
    this.onFavoriteToggled,
  });

  void _storeBotRecipe(BuildContext context, Recipe recipe) {
    final recipeMessage =
        '${recipe.title}\nPrep Time: ${recipe.prepTime ?? 'N/A'}\nIngredients: ${recipe.ingredients.join(', ')}\nInstructions: ${recipe.instructions.join(', ')}';
    final botMessage = StoreMessage(message: recipeMessage, is_bot: true);
    BlocProvider.of<ChatBloc>(context).add(SendChatMessageEvent(botMessage));
  }

  Recipe? _parseRecipeMessage(String message) {
    try {
      final lines = message.split('\n');
      if (lines.length < 4) return null;
      return Recipe(
        title: lines[0],
        prepTime: lines[1].split(': ')[1],
        ingredients: lines[2].split(': ')[1].split(', '),
        instructions: lines[3].split(': ')[1].split(', '),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MultiBlocListener(
            listeners: [
              BlocListener<RecipeBloc, RecipeState>(
                listener: (context, state) {
                  if (state is RecipeLoaded && state.recipe != null) {
                    final recipe = state.recipe!;
                    _storeBotRecipe(context, recipe);
                  } else if (state is RecipeError) {
                    onError(state.message);
                  }
                },
              ),
              BlocListener<ChatBloc, ChatState>(
                listener: (context, state) {
                  if (state is ChatMessageLoaded) {
                    final message = state.message;
                    final parsedRecipe = message.me
                        ? null
                        : _parseRecipeMessage(message.message);
                    onNewMessage(StoreMessageResponse(
                      id: message.id,
                      message: message.message,
                      me: message.me,
                      createdAt: message.createdAt,
                      favourite: message.favourite,
                      isRecipe: parsedRecipe != null,
                      recipe: parsedRecipe,
                    ));
                  } else if (state is ChatError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                    onError(state.message);
                  } else if (state is ChatFavoriteToggled) {
                    onFavoriteToggled?.call(state.messageId, state.isFavourite);
                  }
                },
              ),
            ],
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isBot = !message.me;

                return Row(
                  mainAxisAlignment:
                      isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isBot)
                      CircleAvatar(
                        maxRadius: 15,
                        backgroundColor: Color(0xff5EDA42),
                        child: SvgPicture.asset(
                          Assets.imagesChef,
                          color: Colors.white,
                          width: 21.43,
                        ),
                      ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 4, bottom: 4, right: 8, left: 8),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: isBot ? Color(0xffEDFBEA) : Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Stack(
                          children: [
                            if (message.isRecipe && message.recipe != null)
                              RecipeCard(recipe: message.recipe!)
                            else
                              Text(
                                message.message,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Noto Sans",
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff333333),
                                ),
                              ),
                            if (isBot)
                              Positioned(
                                top: -10,
                                right: -10,
                                child: IconButton(
                                  icon: Icon(
                                    message.favourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        message.favourite ? Colors.red : null,
                                  ),
                                  onPressed: message.id <= 0
                                      ? null
                                      : () {
                                          BlocProvider.of<ChatBloc>(context)
                                              .add(
                                            ToggleFavoriteEvent(
                                                message.id, !message.favourite),
                                          );
                                        },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (!isBot)
                      const CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://i.pravatar.cc/150?img=3'),
                        maxRadius: 15,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
        ChatInputField(controller: controller, onSend: onSend),
        RichText(
          text: TextSpan(
            text: "Not sure what to cook? ",
            style: TextStyle(
              fontSize: 11,
              color: Color(0xff999999),
              fontWeight: FontWeight.w400,
              fontFamily: "Noto Sans",
            ),
            children: [
              TextSpan(
                text: "let Chatbite help!",
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Sans",
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}
