import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../domain/entities/tracking_product_request_entity.dart';
import '../bloc/tracking_product_bloc.dart';
import '../bloc/tracking_product_event.dart';
import '../bloc/tracking_product_state.dart';
import '../widgets/product_form_widget.dart';

class AddEditProductPage extends StatelessWidget {
  final TrackingProduct? initialProduct;
  final int? productId;
  final Function(bool) onPageOpened;

  const AddEditProductPage({
    super.key,
    this.initialProduct,
    this.productId,
    required this.onPageOpened,
  });

  @override
  Widget build(BuildContext context) {
    final isEdit = initialProduct != null || productId != null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageOpened(isEdit);
      print('Initializing AddEditProductPage, isEdit: $isEdit, product: $initialProduct, productId: $productId'); // Debug log
      context.read<TrackingAddEditBloc>().add(InitializeForm(initialProduct));
    });

    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit item' : 'Add item',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: 'Noto Sans',
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFFFF),
        elevation: 0,
        shape: Border(bottom: BorderSide(color: Color(0xffCCCCCC))),
        toolbarHeight: 55,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SvgPicture.asset(
              Assets.back,
              width: 20.w,
              height: 20.h,
            ),
          ),
        ),
      ),
      body: BlocConsumer<TrackingAddEditBloc, TrackingAddEditState>(
        listener: (context, state) {
          if (state is TrackingAddEditFailure) {
            print('Failure state: ${state.errorMessage}'); // Debug log
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.errorMessage}'),
                duration: Duration(seconds: 3),
              ),
            );
          } else if (state is TrackingAddEditLoaded) {
            print('Success state: ${state.product}'); // Debug log
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${isEdit ? 'Updated' : 'Added'} successfully!'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          print('Building AddEditProductPage with state: $state'); // Debug log
          if (state is TrackingAddEditLoading) {
            return const Center(child: LoadingWidget());
          }
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: ProductFormWidget(
              isEdit: isEdit,
              productId: productId,
            ),
          );
        },
      ),
    );
  }
}