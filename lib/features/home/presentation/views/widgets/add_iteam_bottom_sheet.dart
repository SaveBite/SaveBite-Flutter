import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/core/utils/app_styles.dart';
import 'package:save_bite/features/home/presentation/manger/products_cubit/products_cubit.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_add_iteam_field.dart';
import 'package:save_bite/features/home/presentation/views/widgets/custom_date_field.dart';
import 'package:save_bite/features/home/presentation/views/widgets/month_date_field.dart';

class AddIteamBottomSheet extends StatefulWidget {
  const AddIteamBottomSheet({super.key});

  @override
  State<AddIteamBottomSheet> createState() => _AddIteamBottomSheetState();
}

class _AddIteamBottomSheetState extends State<AddIteamBottomSheet> {
  GlobalKey<FormState> mykey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          )),
      child: SingleChildScrollView(
        child: Form(
          key: mykey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add item',
                style: AppStyles.styleBold19.copyWith(
                  fontSize: 17,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Date',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff666666),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              CustomDateField(),
              CustomAddIteamField(
                title: 'Product Name',
                onChanged: (value) {
                  BlocProvider.of<ProductsCubit>(context).productName = value;
                },
              ),
              LineThree(),
              LineFour(),
              LineFive(),
              CustomAddIteamField(
                title: 'Sales Value',
                onChanged: (value) {
                  BlocProvider.of<ProductsCubit>(context).salesValue = value;
                },
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Month',
                style: AppStyles.styleRegular16.copyWith(
                  color: Color(0xff666666),
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              MonthDateField(),
              SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: () {
                  if (mykey.currentState!.validate()) {
                    BlocProvider.of<ProductsCubit>(context).addProduct();
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  height:
                      MediaQuery.of(context).size.height * 0.0551643192488263,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff5EDA42),
                  ),
                  child: Center(
                    child: Text(
                      'Add Iteam',
                      style: AppStyles.styleBold19
                          .copyWith(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LineFive extends StatelessWidget {
  const LineFive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: CustomAddIteamField(
              title: 'Reorder Quantity',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).reorderQuantity = value;
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: CustomAddIteamField(
              title: 'Units Sold',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).unitsSold = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LineFour extends StatelessWidget {
  const LineFour({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: CustomAddIteamField(
              title: 'Quantity',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).stockQuantity = value;
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: CustomAddIteamField(
              title: 'Reorder Level',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).reorderLevel = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class LineThree extends StatelessWidget {
  const LineThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: CustomAddIteamField(
              title: 'Category',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).category = value;
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: CustomAddIteamField(
              title: 'Price',
              onChanged: (value) {
                BlocProvider.of<ProductsCubit>(context).unitPrice = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
