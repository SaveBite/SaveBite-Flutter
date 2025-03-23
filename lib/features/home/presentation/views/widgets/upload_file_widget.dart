import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';

class UploadFilesWidget extends StatefulWidget {
  const UploadFilesWidget({super.key});

  @override
  State<UploadFilesWidget> createState() => _UploadFilesWidgetState();
}

class _UploadFilesWidgetState extends State<UploadFilesWidget> {
  bool _isPressed = false;

  Future<void> _pickFile(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'], // السماح بملفات CSV فقط
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        BlocProvider.of<ProductsCubit>(context).productsFile = file;
        await BlocProvider.of<ProductsCubit>(context).uploadProducts();
        //
      } else {}
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      dashPattern: [5, 5],
      color: Color(0xff5EDA42),
      strokeWidth: 1,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() {
            _isPressed = true;
          });
        },
        onTapUp: (_) {
          setState(() {
            _isPressed = false;
          });
          _pickFile(context);
        },
        onTapCancel: () {
          setState(() {
            _isPressed = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _isPressed ? Colors.grey[200] : Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.imagesUploadFile,
              ),
              const SizedBox(height: 12),
              Text(
                'Drag and Drop to upload',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'or browse',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
