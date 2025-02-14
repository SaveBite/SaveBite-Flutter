import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_bite/core/utils/app_assets.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/authentication/login/presentation/manger/login_cubit/login_cubit.dart';

class UplaodImageTextField extends StatefulWidget {
  const UplaodImageTextField({super.key});

  @override
  State<UplaodImageTextField> createState() => _UplaodImageTextFieldState();
}

class _UplaodImageTextFieldState extends State<UplaodImageTextField> {
  File? imagePath;
  String? _imageName;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = File(image.path);
        BlocProvider.of<LoginCubit>(context).image = imagePath;
        _imageName = image.name;
        BlocProvider.of<LoginCubit>(context).chaneButtomColor();
      });
    }
  }

  void _clearImage() {
    setState(() {
      imagePath = null;
      BlocProvider.of<LoginCubit>(context).image = null;
      _imageName = null;
      BlocProvider.of<LoginCubit>(context).chaneButtomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffCCCCCC),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          if (imagePath == null) ...[
            InkWell(
              onTap: _pickImage,
              child: Container(
                height: 38,
                width: 84,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffE6E6E6),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xff666666),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Choose File',
                    style: AppStyles.styleRegular16.copyWith(
                      fontSize: 12,
                      color: const Color(0xff666666),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _imageName ?? 'No File Chosen',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.styleRegular13.copyWith(
                  color: const Color(0xffCCCCCC),
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: _pickImage,
              child: SvgPicture.asset(Assets.imagesUploadIcon),
            ),
          ] else ...[
            Expanded(
              child: Text(
                _imageName ?? '',
                overflow: TextOverflow.ellipsis,
                style: AppStyles.styleRegular13.copyWith(
                  color: const Color(0xff333333),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: _clearImage,
              child: SvgPicture.asset(Assets.imagesClose),
            ),
          ],
        ],
      ),
    );
  }
}
