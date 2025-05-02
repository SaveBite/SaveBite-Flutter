import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domain/usecases/get_chat_messages.dart';
import '../bloc/chat_bloc/chat_bloc.dart';
import '../bloc/chat_bloc/chat_event.dart';
import '../bloc/recipe_bloc/recipe_bloc.dart';
import '../bloc/recipe_bloc/recipe_event.dart';
import '../widgets/chatbot_welcome_screen.dart';
import '../widgets/chat_screen.dart';
import '../../domain/entities/store_message.dart';
import '../../domain/entities/store_message_response.dart';



class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  _ChatBotViewBodyState createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<StoreMessageResponse> _messages = [];
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _fetchChatMessages();
    BlocProvider.of<RecipeBloc>(context).add(InitializeChatBotEvent());
  }

  void _fetchChatMessages() async {
    final getChatMessages = sl<GetChatMessages>();
    final result = await getChatMessages();
    result.fold(
          (failure) {
        if (mounted) {
          setState(() {
            _messages.add(StoreMessageResponse(
              id: -1,
              message: '❌ Error: ${failure.message}',
              me: false,
              createdAt: DateTime.now(),
              favourite: false,
              isRecipe: false,
            ));
          });
        }
      },
          (messages) {
        if (mounted) {
          setState(() {
            _messages.addAll(messages);
            _scrollToBottom();
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _isFirstTime = false;
      _messages.add(StoreMessageResponse(
        id: -1,
        message: text,
        me: true,
        createdAt: DateTime.now(),
        favourite: false,
        isRecipe: false,
      ));
      _scrollToBottom();
    });

    final userMessage = StoreMessage(message: text, is_bot: false);
    BlocProvider.of<ChatBloc>(context).add(SendChatMessageEvent(userMessage));

    BlocProvider.of<RecipeBloc>(context).add(GetRecipeEvent(text));

    _controller.clear();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isFirstTime
        ? ChatWelcomeScreen(onSend: _sendMessage, controller: _controller)
        : ChatScreen(
      messages: _messages,
      controller: _controller,
      scrollController: _scrollController,
      onSend: _sendMessage,
      onNewMessage: (message) {
        setState(() {
          if (message.me) {
            final index = _messages.indexWhere((m) => m.id == -1 && m.me);
            if (index != -1) {
              _messages[index] = message;
            } else {
              _messages.add(message);
            }
          } else {
            _messages.add(message);
          }
        });
        _scrollToBottom();
      },
      onError: (msg) {
        setState(() {
          _messages.add(StoreMessageResponse(
            id: -1,
            message: '❌ Error: $msg',
            me: false,
            createdAt: DateTime.now(),
            favourite: false,
            isRecipe: false,
          ));
        });
        _scrollToBottom();
      },
      onFavoriteToggled: (messageId, isFavourite) {
        setState(() {
          final index = _messages.indexWhere((m) => m.id == messageId);
          if (index != -1) {
            _messages[index] = StoreMessageResponse(
              id: _messages[index].id,
              message: _messages[index].message,
              me: _messages[index].me,
              createdAt: _messages[index].createdAt,
              favourite: isFavourite,
              isRecipe: _messages[index].isRecipe,
              recipe: _messages[index].recipe,
            );
          }
        });
      },
    );
  }
}