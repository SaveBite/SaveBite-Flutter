import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/app_assets.dart';
import '../bloc/tracking_product_bloc.dart';
import '../bloc/tracking_product_event.dart';
import '../bloc/tracking_product_state.dart';

class ImageSectionContainer extends StatefulWidget {
  final String? imagePath;
  final Function(String?) onPickImage;
  final VoidCallback onClearImage;

  ImageSectionContainer(
      {required this.imagePath,
      required this.onPickImage,
      required this.onClearImage});

  @override
  State<ImageSectionContainer> createState() => _ImageSectionContainerState();
}

class _ImageSectionContainerState extends State<ImageSectionContainer> {
  late String? _selectedFile;
  late bool _hasError;
  final ImagePicker _picker = ImagePicker();


  @override
  void initState() {
    super.initState();
    _selectedFile = widget.imagePath;
    _hasError = false;
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = pickedFile.path;
        _hasError = false;
      });
      widget.onPickImage(pickedFile.path);
    }
  }

  void _clearImage() {
    setState(() {
      _selectedFile = null;
      _hasError = true;
    });
    widget.onClearImage();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TrackingAddEditBloc, TrackingAddEditState>(
      buildWhen: (previous, current) {
        if (current is! TrackingAddEditInitial ||
            previous is! TrackingAddEditInitial) {
          return current is TrackingAddEditInitial;
        }

        final prev = previous as TrackingAddEditInitial;
        final curr = current as TrackingAddEditInitial;

        final imageChanged =
            prev.selectedImage?.path != curr.selectedImage?.path;

        return imageChanged ||
            prev.imageUrl != curr.imageUrl ||
            prev.isLoadingImage != curr.isLoadingImage;
      },
      builder: (context, state) {
        // Early return if state is not TrackingAddEditInitial
        if (state is! TrackingAddEditInitial) return const SizedBox.shrink();

        // Cast state to TrackingAddEditInitial to avoid type errors
        final initialState = state as TrackingAddEditInitial;
        final bloc = context.read<TrackingAddEditBloc>();
        final selectedImage = initialState.selectedImage;
        final imageUrl = initialState.imageUrl;
        final isLoadingImage = initialState.isLoadingImage;
        final hasImage = selectedImage != null || imageUrl != null;

        return FormField(builder: (FormFieldState<String> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Expiration Date",
                  style: TextStyle(fontSize: 16, color: Color(0xff333333))),
              SizedBox(height: 4.h),
              Text(
                "Upload product image to extract expiration dates from it.",
                style: TextStyle(color: Color(0xff999999), fontSize: 11),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 286,
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffB6EEAA), width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    if (!hasImage)
                      DottedBorder(
                        color: const Color(0xffCCCCCC),
                        strokeWidth: 1.5,
                        dashPattern: [6, 4],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Container(
                            height: 182,
                            width: double.infinity,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(Assets.image),
                                SizedBox(height: 12),
                                Text(
                                  "Please make sure your photo clearly\nshows the expiration date.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6.r),
                        child: Container(
                          height: 182,
                          width: double.infinity,
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Builder(
                                  builder: (_) {
                                    if (selectedImage != null) {
                                      return Image.file(
                                        selectedImage,
                                        fit: BoxFit.cover,
                                        key: ValueKey(selectedImage.path),
                                      );
                                    } else if (imageUrl != null &&
                                        imageUrl.isNotEmpty) {
                                      return Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        key: ValueKey(imageUrl),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ),
                              if (isLoadingImage)
                                Positioned.fill(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.4),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: 12),
                    hasImage
                        ? Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: isLoadingImage
                                      ? null
                                      : () => bloc.add(ScanImage()),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.h, horizontal: 8.w),
                                  ),
                                  child: const Text("Scan",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      bloc.add(ClearSelectedImage());
                                    });
                                  },
                                  // onPressed: () => Future.microtask(
                                  //     () => bloc.add(ClearSelectedImage())),

                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.h, horizontal: 8.w),
                                  ),
                                  child: const Text("Delete",
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 32,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () =>
                                      bloc.add(PickImage(ImageSource.camera)),
                                  label: Text('Take photo',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff5EDA42),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.h, horizontal: 8.w),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 32,
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    bloc.add(PickImage(ImageSource.gallery));
                                  },
                                  label: Text('Choose from Camera roll',
                                      style: TextStyle(color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff5EDA42),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.h, horizontal: 8.w),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
