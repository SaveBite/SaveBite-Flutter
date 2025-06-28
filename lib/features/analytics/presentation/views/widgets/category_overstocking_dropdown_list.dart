import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';

class CategoryOverstockingDropDownList extends StatefulWidget {
  final List<String> items;
  final Function(String?)? onItemSelected;

  const CategoryOverstockingDropDownList({
    super.key,
    required this.items,
    this.onItemSelected,
  });

  @override
  State<CategoryOverstockingDropDownList> createState() =>
      _CategoryOverstockingDropDownListState();
}

class _CategoryOverstockingDropDownListState
    extends State<CategoryOverstockingDropDownList> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.items.isNotEmpty ? widget.items[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68.0,
      height: 26.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
          width: 1.0,
        ),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 210.0,
          maxWidth: 68.0,
        ),
        child: PopupMenuButton<String>(
          onSelected: (String newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(newValue);
            }
          },
          itemBuilder: (BuildContext context) {
            return widget.items.map((String item) {
              return PopupMenuItem<String>(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  child: Text(
                    item,
                    style: AppStyles.styleBold11.copyWith(
                      color: const Color(0xffB3B3B3),
                      fontSize: 9,
                    ),
                  ),
                ),
              );
            }).toList();
          },
          offset: const Offset(0, 26),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // Use Expanded here
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    _selectedValue ?? "",
                    overflow: TextOverflow.ellipsis, // Add this line
                    style: AppStyles.styleBold11.copyWith(
                      color: const Color(0xffB3B3B3),
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 4,
                ),
                child: Transform.scale(
                  scale: 0.9,
                  child: SvgPicture.asset(Assets.imagesDropDownIteam),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
