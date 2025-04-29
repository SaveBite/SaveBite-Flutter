import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/lost_image/presentation/manger/lost_image_cubit/lost_image_cubit.dart';
// ... other imports

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String dropdownValue = 'What is your favorite drink?';
  List<String> options = [
    '5arbosh shay',
    'Mango',
    'Coffee',
    'Sahlb',
    'Farawla'
  ];
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      // Use a Column to position the dropdown below the field
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffCCCCCC)),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(dropdownValue, style: AppStyles.styleMedium16),
                Transform.rotate(
                  angle: isExpanded ? -pi / 1 : 0,
                  child: SvgPicture.asset(Assets.imagesDownIcon),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded) // Show the dropdown directly below the field
          Container(
            margin: const EdgeInsets.only(top: 4), // Add some spacing
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffCCCCCC)),
              borderRadius: BorderRadius.circular(4),
              color: Colors.white, // Set background color to white
            ),
            child: ListView.builder(
              shrinkWrap: true, // Important: prevent unbounded height
              itemCount: options.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      dropdownValue = options[index];
                      BlocProvider.of<LostImageCubit>(context).answer =
                          (index + 1).toString();
                      BlocProvider.of<LostImageCubit>(context)
                          .changeLostImageButtomColor();
                      isExpanded = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: dropdownValue == options[index]
                        ? const Color(0xff2E70FE)
                        : null,
                    child: Text(
                      options[index],
                      style: AppStyles.styleMedium16.copyWith(
                        color: dropdownValue == options[index]
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
