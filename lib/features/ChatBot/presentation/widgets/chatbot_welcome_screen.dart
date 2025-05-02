import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_assets.dart';
import 'chat_input_field.dart';

class ChatWelcomeScreen extends StatelessWidget {
  final void Function(String) onSend;
  final TextEditingController controller;

  const ChatWelcomeScreen(
      {super.key, required this.onSend, required this.controller});

  Widget _buildSuggestionButton(CircleAvatar circleAvatar, String suggestion) {
    return GestureDetector(
      onTap: ()=> onSend(suggestion) ,
      child: Container(
        padding: EdgeInsets.all(12),
        width: 115,
        height: 152,
        decoration: BoxDecoration(
            color: Color(0xffFFFFFF),
            border: Border.all(color: Color(0xffE2E2E2)),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            circleAvatar,
            Spacer(),
            Text(
              suggestion,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xff999999),
                  fontFamily: "Noto Sans"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.imagesChef),
                const SizedBox(height: 16),
                const Text('Hi, there 👋',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily: "Noto Sans")),
                const SizedBox(height: 8),
                const Text(
                  'Here to help you with ideas, advice and more! What would you like to cook today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0xffB3B3B3),
                      fontFamily: "Noto Sans",
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 24),
                Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: _buildSuggestionButton(
                            CircleAvatar(
                              backgroundColor: Color(0xffEDFBEA),
                              child: SvgPicture.asset(Assets.imagesMenu),
                            ),
                            'What can I cook with rice, chicken, and carrots?')),
                    Expanded(
                        child: _buildSuggestionButton(
                            CircleAvatar(
                              backgroundColor: Color(0xffFFEBF4),
                              child: SvgPicture.asset(Assets.imagesClock),
                            ),
                            'Suggest a quick dinner recipe under 20 minutes.')),
                    Expanded(
                        child: _buildSuggestionButton(
                            CircleAvatar(
                              backgroundColor: Color(0xffFFEEE8),
                              child: SvgPicture.asset(Assets.imagesProtected),
                            ),
                            'How can I store leftover pasta to keep it fresh?')),
                  ],
                ),
                const SizedBox(height: 26),
              ],
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
                  fontFamily: "Noto Sans"

              ),
              children: [
                TextSpan(
                  text: "let Chatbite help!",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Noto Sans"
                  ),
                )
              ]),
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}
