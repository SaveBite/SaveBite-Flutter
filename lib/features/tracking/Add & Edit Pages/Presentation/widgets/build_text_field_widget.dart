
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/tracking_product_bloc.dart';
import '../bloc/tracking_product_state.dart';

Widget buildTextField({
  required String label,
  TextInputType? keyboardType,
  required Function(String) onChanged,
  TextEditingController? controller,
  bool isDate = true,

}) {
  return BlocBuilder<TrackingAddEditBloc, TrackingAddEditState>(
    builder: (context, state) {
      final value = state is TrackingAddEditInitial
          ? (label == 'Product Name'
          ? state.name
          : label == 'ID No'
          ? state.numberId
          : label == 'Category'
          ? state.category
          : label == 'Label'
          ? state.label
          : label == 'Quantity'
          ? state.quantity
          : label == 'Start Date'
          ? state.startDate
          : state.expiryDate) ??
          ''
          : '';

      final isDateField = label == 'Start Date' || label == 'Expiration Date';


      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xff333333),
              fontSize: isDateField ? 16 : 13,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: 8.h),
          SizedBox(
            height: 40,
            child:
            TextFormField(
              controller: controller, // Use controller if passed (e.g., for Expiry Date)
              initialValue: controller == null ? value : null, // ✅ Avoid Flutter crash
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.r)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff5EDA42), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xffCCCCCC)),
                  borderRadius: BorderRadius.circular(4),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFF0000)),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffFF0000)), // Red border on error
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 16),
              ),
              onChanged: onChanged,
              validator: (value) => value!.isEmpty ? '$label is required' : null,
            )
          ),
        ],
      );
    },
  );
}