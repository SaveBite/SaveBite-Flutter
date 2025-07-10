import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/tracking_product_request_entity.dart';

abstract class TrackingAddEditEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeForm extends TrackingAddEditEvent {
  final TrackingProduct? product;

  InitializeForm(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateName extends TrackingAddEditEvent {
  final String name;

  UpdateName(this.name);

  @override
  List<Object> get props => [name];
}

class UpdateNumberId extends TrackingAddEditEvent {
  final String numberId;

  UpdateNumberId(this.numberId);

  @override
  List<Object> get props => [numberId];
}

class UpdateCategory extends TrackingAddEditEvent {
  final String category;

  UpdateCategory(this.category);

  @override
  List<Object> get props => [category];
}

class UpdateLabel extends TrackingAddEditEvent {
  final String label;

  UpdateLabel(this.label);

  @override
  List<Object> get props => [label];
}

class UpdateQuantity extends TrackingAddEditEvent {
  final String quantity;

  UpdateQuantity(this.quantity);

  @override
  List<Object> get props => [quantity];
}

class UpdateStartDate extends TrackingAddEditEvent {
  final String startDate;

  UpdateStartDate(this.startDate);

  @override
  List<Object> get props => [startDate];
}

class UpdateExpiryDate extends TrackingAddEditEvent {
  final String expiryDate;

  UpdateExpiryDate(this.expiryDate);

  @override
  List<Object> get props => [expiryDate];
}

class PickImage extends TrackingAddEditEvent {
  final ImageSource source;

  PickImage(this.source);

  @override
  List<Object> get props => [source];
}

class SubmitForm extends TrackingAddEditEvent {}

class ClearSelectedImage extends TrackingAddEditEvent {}

class ScanImage extends TrackingAddEditEvent {}

class ClearForm extends TrackingAddEditEvent {}
