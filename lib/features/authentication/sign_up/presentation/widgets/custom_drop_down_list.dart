import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';

class CustomDropdown extends StatefulWidget {
  final OptionItem? selectedItem;
  final List<OptionItem> options;
  final Function(OptionItem) onOptionSelected;
  final String hintText;
  final Color textColor;
  final IconData? icon;
  final String labelText;

  const CustomDropdown({
    Key? key,
    required this.selectedItem,
    required this.options,
    required this.onOptionSelected,
    required this.hintText,
    this.textColor = Colors.black,
    this.icon,
    required this.labelText,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isExpanded = false;
  OptionItem? _hoveredItem;
  OptionItem? _selectedItem; // Maintain state for selected item

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<OptionItem>(
      validator: (value) {
        return _selectedItem == null
            ? 'Please complete this required field'
            : null;
      },
      builder: (FormFieldState<OptionItem> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.labelText,
              style: AppStyles.styleRegular16,
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red // ✅ Error border
                        : (_isExpanded ? Color(0xff5EDA42) : Color(0xffCCCCCC)),
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                padding: EdgeInsets.symmetric(horizontal: 13, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedItem?.title ?? widget.hintText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Noto Scans',
                        color: _selectedItem == null
                            ? Color(0xffCCCCCC)
                            : Colors.black,
                      ),
                    ),
                    SvgPicture.asset(
                      _isExpanded
                          ? Assets.imagesUploadIcon
                          : Assets.imagesDownIcon,
                      height: 22.5,
                      width: 22.5,
                    ),
                  ],
                ),
              ),
            ),
            if (_isExpanded)
              Container(
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffCCCCCC), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: widget.options.map((item) {
                    return MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _hoveredItem = item;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _hoveredItem = null;
                        });
                      },
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = false;
                            _selectedItem = item; // ✅ Update selected item
                          });

                          widget.onOptionSelected(item);
                          state.didChange(item); // ✅ Notify form of change
                          Form.of(context)
                              ?.validate(); // ✅ Force validation check
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              horizontal: 13, vertical: 16),
                          decoration: BoxDecoration(
                            color: _selectedItem == item
                                ? Color(0xff2E70FE)
                                : _hoveredItem == item
                                    ? Color(0xff2E70FE)
                                    : Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Noto Scans',
                              color:
                                  _selectedItem == item || _hoveredItem == item
                                      ? Color(0xffFFFFFF)
                                      : Color(0xff333333),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (state.hasError) // ✅ Display error message only if needed
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 8),
                child: Text(
                  'Please complete this required field',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }
}

class DropListModel {
  DropListModel(this.listOptionItems);
  final List<OptionItem> listOptionItems;
}

class OptionItem {
  final int id;
  final String title; // Display title
  final dynamic backendValue; // Value sent to backend (can be String or int)

  OptionItem(
      {required this.id, required this.title, required this.backendValue});
}
