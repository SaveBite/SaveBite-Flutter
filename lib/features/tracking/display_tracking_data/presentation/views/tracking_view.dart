import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/custom_tracking_buttom.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/tracking_allert_widget.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/views/widgets/tracking_table.dart';
import 'package:save_bite/features/tracking/display_tracking_data/presentation/manger/tarcking_cubit/tracking_cubit.dart';
import 'package:save_bite/features/tracking/display_tracking_data/domain/entity/tracking_product_entity.dart';

class TrackingView extends StatefulWidget {
  const TrackingView({super.key});

  @override
  State<TrackingView> createState() => _TrackingViewState();
}

class _TrackingViewState extends State<TrackingView> {
  int selectedIndex = 0;

  final List<String> labels = ['All items', 'Expired', 'Near to expire'];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TrackingCubit>(context).getTrackingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: BlocBuilder<TrackingCubit, TrackingState>(
          builder: (context, state) {
            List<TrackingProductEntity> allProducts = [];

            if (state is GetTrackingProductsSuccess) {
              allProducts = state.trackingProducts;
            }

            List<TrackingProductEntity> getFilteredProducts(int index) {
              if (index == 1) {
                return allProducts.where((e) => e.status == 'expired').toList();
              } else if (index == 2) {
                return allProducts
                    .where((e) => e.status == 'near-to-expire')
                    .toList();
              } else {
                return allProducts;
              }
            }

            int getCount(int index) => getFilteredProducts(index).length;

            return Column(
              children: [
                // Scrollable Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(3, (index) {
                      final bool isSelected = selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected
                                    ? const Color(0xFF5EDA42)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                labels[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xFF5EDA42)
                                      : const Color(0xFFB3B3B3),
                                ),
                              ),
                              const SizedBox(width: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF5EDA42)
                                      : const Color(0xFFB3B3B3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                constraints: const BoxConstraints(minWidth: 18),
                                child: Center(
                                  child: Text(
                                    getCount(index).toString(),
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const CustomTrackingButton(),

                // Body
                Expanded(
                  child: Builder(
                    builder: (_) {
                      if (state is GetTrackingProductsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is GetTrackingProductsFailurs) {
                        return Center(
                          child: Text(
                            state.errorMesaage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      } else if (state is TrackingInitial) {
                        return const TrackingAllertWidget();
                      } else if (state is GetTrackingProductsSuccess) {
                        final filtered = getFilteredProducts(selectedIndex);
                        return TrackingTaple(items: filtered);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
