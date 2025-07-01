import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_assets.dart';


class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Ask me for a recipe or cooking tip...',
                hintStyle: const TextStyle(
                  color: Color(0xffCCCCCC),
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Noto Sans",
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: SizedBox(
                  width: 80,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: SvgPicture.asset(Assets.imagesChooseMenu),
                        onTap: () {},
                      ),
                      SizedBox(width: 8),
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: controller,
                        builder: (context, value, child) {
                          return InkWell(
                            child: CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: value.text.isNotEmpty
                                  ? Color(0xff5EDA42)
                                  : Color(0xffB3B3B3),
                              child: SvgPicture.asset(Assets.imagesSend),
                            ),
                            onTap: () {
                              onSend(controller.text);
                            },
                          );
                        },
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Color(0xffEDE4E4)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Color(0xff5EDA42), width: 2),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  borderSide: BorderSide(color: Color(0xffEDE4E4), width: 1),
                ),
              ),
              onSubmitted: (value) => onSend(value),
            ),
          ),
        ],
      ),
    );
  }
}