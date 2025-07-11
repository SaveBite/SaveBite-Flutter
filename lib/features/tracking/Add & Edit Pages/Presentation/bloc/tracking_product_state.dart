import 'package:equatable/equatable.dart';
import 'dart:io';

import '../../domain/entities/tracking_product_request_entity.dart';

abstract class TrackingAddEditState extends Equatable {
  const TrackingAddEditState();

  @override
  List<Object?> get props => [];

}

class TrackingAddEditInitial extends TrackingAddEditState {
  final int? id;
  final String name;
  final String numberId;
  final String category;
  final String label;
  final String quantity;
  final String? startDate;
  final String expiryDate;
  final String? imageUrl;
  final File? selectedImage;
  final bool isEditMode;
  final bool isLoadingImage;

  const TrackingAddEditInitial({
    this.id,
    this.name = '',
    this.numberId = '',
    this.category = '',
    this.label = '',
    this.quantity = '',
    this.startDate,
    this.expiryDate = '',
    this.imageUrl,
    this.selectedImage,
    this.isEditMode = false,
    this.isLoadingImage = false,
  });



  TrackingAddEditInitial copyWith({
    int? id,
    String? name,
    String? numberId,
    String? category,
    String? label,
    String? quantity,
    String? startDate,
    String? expiryDate,
    String? imageUrl,
    File? newSelectedImage,
    bool? isEditMode,
    bool? isLoadingImage,
  }) {
    return TrackingAddEditInitial(
      id: id ?? this.id,
      name: name ?? this.name,
      numberId: numberId ?? this.numberId,
      category: category ?? this.category,
      label: label ?? this.label,
      quantity: quantity ?? this.quantity,
      startDate: startDate ?? this.startDate,
      expiryDate: expiryDate ?? this.expiryDate,
      imageUrl: imageUrl ?? this.imageUrl,
      selectedImage: newSelectedImage ?? this.selectedImage,
      isEditMode: isEditMode ?? this.isEditMode,
      isLoadingImage: isLoadingImage ?? this.isLoadingImage,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    numberId,
    category,
    label,
    quantity,
    startDate,
    expiryDate,
    imageUrl,
    selectedImage,
    isEditMode,
    isLoadingImage,
  ];
}

class TrackingAddEditLoading extends TrackingAddEditState {}

class TrackingAddEditLoaded extends TrackingAddEditState {
  final TrackingProduct product;

  const TrackingAddEditLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class TrackingAddEditFailure extends TrackingAddEditState {
  final String errorMessage;

  const TrackingAddEditFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}