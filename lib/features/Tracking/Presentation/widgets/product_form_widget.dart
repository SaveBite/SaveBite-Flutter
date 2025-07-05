import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/tracking_product_bloc.dart';
import '../bloc/tracking_product_event.dart';
import '../bloc/tracking_product_state.dart';
import 'build_image_section_widget.dart';
import 'build_text_field_widget.dart';

class ProductFormWidget extends StatefulWidget {
  final bool isEdit;
  final int? productId;

  const ProductFormWidget({super.key, required this.isEdit, this.productId});

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _numberIdController;
  late final TextEditingController _categoryController;
  late final TextEditingController _labelController;
  late final TextEditingController _quantityController;
  late final TextEditingController _startDateController;
  late final TextEditingController _expiryDateController;

  bool _isInitialized = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _nameController = TextEditingController();
  //   _numberIdController = TextEditingController();
  //   _categoryController = TextEditingController();
  //   _labelController = TextEditingController();
  //   _quantityController = TextEditingController();
  //   _startDateController = TextEditingController();
  //   _expiryDateController = TextEditingController();
  // }
  @override
  @override
  void initState() {
    super.initState();

    final bloc = context.read<TrackingAddEditBloc>();
    final state = bloc.state;

    // ✅ Safely access state data by checking its type
    if (state is TrackingAddEditInitial) {
      _nameController = TextEditingController(text: state.name ?? '');
      _numberIdController = TextEditingController(text: state.numberId ?? '');
      _categoryController = TextEditingController(text: state.category ?? '');
      _labelController = TextEditingController(text: state.label ?? '');
      _quantityController = TextEditingController(text: state.quantity ?? '');
      _startDateController = TextEditingController(text: state.startDate ?? '');
      _expiryDateController = TextEditingController(text: state.expiryDate ?? '');
    } else {
      // fallback in case state is not ready yet (e.g. loading)
      _nameController = TextEditingController();
      _numberIdController = TextEditingController();
      _categoryController = TextEditingController();
      _labelController = TextEditingController();
      _quantityController = TextEditingController();
      _startDateController = TextEditingController();
      _expiryDateController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberIdController.dispose();
    _categoryController.dispose();
    _labelController.dispose();
    _quantityController.dispose();
    _startDateController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<TrackingAddEditBloc, TrackingAddEditState>(
        builder: (context, state) {
          if (state is! TrackingAddEditInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          final bloc = context.read<TrackingAddEditBloc>();

          // Sync controllers with state
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _nameController.text = state.name ?? '';
            _numberIdController.text = state.numberId ?? '';
            _categoryController.text = state.category ?? '';
            _labelController.text = state.label ?? '';
            _quantityController.text = state.quantity ?? '';
            _startDateController.text = state.startDate ?? '';
            _expiryDateController.text = state.expiryDate ?? '';
          });



          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: const BorderSide(width: 1, color: Color(0xffE6E6E6)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.isEdit ? 'Edit Product' : 'Adding new item',
                      style: const TextStyle(
                        color: Color(0xff1A1A1A),
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
                        fontFamily: 'Noto Sans',
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(widget.isEdit ?"Edit your product details to track their expiration dates":
                      "Add your product details to track their expiration dates",
                      style: const TextStyle(
                        fontFamily: 'Noto Sans',
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff999999),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Text Fields
                    ...[
                      buildTextField(
                        label: 'Product Name',
                        controller: _nameController,
                        onChanged: (value) => bloc.add(UpdateName(value)),
                      ),
                      buildTextField(
                        label: 'ID No',
                        controller: _numberIdController,
                        onChanged: (value) => bloc.add(UpdateNumberId(value)),
                      ),
                      buildTextField(
                        label: 'Category',
                        controller: _categoryController,
                        onChanged: (value) => bloc.add(UpdateCategory(value)),
                      ),
                      buildTextField(
                        label: 'Label',
                        controller: _labelController,
                        onChanged: (value) => bloc.add(UpdateLabel(value)),
                      ),
                      buildTextField(
                        label: 'Quantity',
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        onChanged: (value) => bloc.add(UpdateQuantity(value)),
                      ),
                    ]
                        .expand((widget) => [widget, SizedBox(height: 16.h)])
                        .toList(),

                    SizedBox(height: 8.h),

                    // Image Section
                    const ImageSectionWidget(),

                    SizedBox(height: 16.h),

                    // Start & Expiry Dates
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xffF2FFF0),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 1, color: Color(0xffDBF7D4)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: buildTextField(
                                  label: 'Start date',
                                  controller: _startDateController,
                                  onChanged: (value) =>
                                      bloc.add(UpdateStartDate(value)),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Flexible(
                                child: buildTextField(
                                  label: 'End date',
                                  controller: _expiryDateController,
                                  onChanged: (value) =>
                                      bloc.add(UpdateExpiryDate(value)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "If the dates are extracted right, click save or edit manually.",
                            style: TextStyle(
                                fontSize: 11, color: Color(0xff999999)),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => bloc.add(SubmitForm()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff5EDA42),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 8.w,
                                ),
                              ),
                              child: Text(
                                widget.isEdit ? 'Confirm' : 'Add Product',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => bloc.add(ClearForm()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffF6F6F6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 8.w,
                                ),
                              ),
                              child: const Text(
                                "Discard",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
