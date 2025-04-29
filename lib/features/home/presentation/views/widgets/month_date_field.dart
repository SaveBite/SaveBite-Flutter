import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';

class MonthDateField extends StatefulWidget {
  const MonthDateField({super.key});

  @override
  MonthDateFieldState createState() => MonthDateFieldState();
}

class MonthDateFieldState extends State<MonthDateField> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text =
            DateFormat('yyyy-MM').format(picked); // تعديل هنا
        BlocProvider.of<ProductsCubit>(context).month = _dateController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'this field is requied';
        } else {
          return null;
        }
      },
      controller: _dateController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        hintText: 'YYYY-MM',
        hintStyle: AppStyles.styleMedium16.copyWith(
          color: Color(0xffCCCCCC),
          fontSize: 14,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Transform.scale(
            scale: 0.4,
            child: SvgPicture.asset(
              Assets.imagesCalender,
            ),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Color(0xffCCCCCC),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffCCCCCC),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Color(0xffCCCCCC),
            width: 1,
          ),
        ),
      ),
      readOnly: true, // اجعل الحقل للقراءة فقط لمنع الكتابة اليدوية
      onTap: () {
        _selectDate(context);
      },
    );
  }
}
