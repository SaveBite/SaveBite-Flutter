import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:save_bite/features/Tracking/Presentation/bloc/tracking_product_event.dart';
import 'package:save_bite/features/Tracking/Presentation/bloc/tracking_product_state.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/edit_product_use_case.dart';
import '../../domain/usecases/extract_date_from_image_use_case.dart';


class TrackingAddEditBloc extends Bloc<TrackingAddEditEvent, TrackingAddEditState> {
  final AddTrackingProductUseCase addTrackingProductUseCase;
  final UpdateTrackingProductUseCase updateTrackingProductUseCase;
  final ExtractDateFromImageUseCase extractDateFromImageUseCase;

  TrackingAddEditBloc({
    required this.addTrackingProductUseCase,
    required this.updateTrackingProductUseCase,
    required this.extractDateFromImageUseCase,
  }) : super(const TrackingAddEditInitial()) {
    on<InitializeForm>(_onInitializeForm);
    on<UpdateName>((e, emit) => _updateState(emit, name: e.name));
    on<UpdateNumberId>((e, emit) => _updateState(emit, numberId: e.numberId));
    on<UpdateCategory>((e, emit) => _updateState(emit, category: e.category));
    on<UpdateLabel>((e, emit) => _updateState(emit, label: e.label));
    on<UpdateQuantity>((e, emit) => _updateState(emit, quantity: e.quantity));
    on<UpdateStartDate>((e, emit) => _updateState(emit, startDate: e.startDate));
    on<UpdateExpiryDate>((e, emit) => _updateState(emit, expiryDate: e.expiryDate));
    on<PickImage>(_onPickImage);
    on<ClearSelectedImage>(_onClearSelectedImage);
    on<ScanImage>(_onScanImage);
    on<SubmitForm>(_onSubmitForm);
    on<ClearForm>(_onClearForm);
  }


  void _onInitializeForm(InitializeForm event, Emitter<TrackingAddEditState> emit) {
    final product = event.product;

    if (product != null) {
      emit(TrackingAddEditInitial(
        id: product.id,
        name: product.name ?? '',
        numberId: product.numberId ?? '',
        category: product.category ?? '',
        label: product.label ?? '',
        quantity: product.quantity.toString() ?? '',
        startDate: product.startDate ?? '',
        expiryDate: product.endDate ?? '',
        imageUrl: product.imageUrl ?? '',
        selectedImage: null,
        isEditMode: true,
      ));
    } else {
      emit(const TrackingAddEditInitial(
        id: null,
        name: '',
        numberId: '',
        category: '',
        label: '',
        quantity: '',
        startDate: '',
        expiryDate: '',
        imageUrl: null,
        selectedImage: null,
        isEditMode: false,
      ));
    }
  }


  // void _onInitializeForm(InitializeForm event, Emitter<TrackingAddEditState> emit) {
  //   // print('Initializing form with product: ${event.product}'); // Debug log
  //   emit(TrackingAddEditInitial(
  //     id: event.product!.id,
  //     name: '',
  //     numberId: '',
  //     category: '',
  //     label: '',
  //     quantity: '',
  //     startDate: '',
  //     expiryDate: '',
  //     imageUrl: '',
  //     selectedImage: null,
  //     isEditMode: event.product != null || state is TrackingAddEditInitial && (state as TrackingAddEditInitial).id != null,
  //   ));
  // }

  void _updateState(
      Emitter<TrackingAddEditState> emit, {
        String? name,
        String? numberId,
        String? category,
        String? label,
        String? quantity,
        String? startDate,
        String? expiryDate,
      }) {
    final current = state;
    if (current is TrackingAddEditInitial) {
      emit(current.copyWith(
        name: name,
        numberId: numberId,
        category: category,
        label: label,
        quantity: quantity,
        startDate: startDate,
        expiryDate: expiryDate,
      ));
    } else {
      print('Cannot update state, current state is not TrackingAddEditInitial: $current'); // Debug log
    }
  }

  Future<void> _onPickImage(PickImage event, Emitter<TrackingAddEditState> emit) async {
    final picker = ImagePicker();
    try {
      final file = await picker.pickImage(source: event.source);
      if (file == null) {
        print('No image selected, reverting to initial state'); // Debug log
        emit(state is TrackingAddEditInitial ? state : const TrackingAddEditInitial());
        return;
      }

      final current = state;
      if (current is TrackingAddEditInitial) {
        print('Setting selectedImage: ${file.path}'); // Debug log
        emit(current.copyWith(newSelectedImage: File(file.path)));
      } else {
        print('Cannot pick image, state is not TrackingAddEditInitial: $current'); // Debug log
        emit(const TrackingAddEditInitial().copyWith(newSelectedImage: File(file.path)));
      }
    } catch (e) {
      print('Image pick error: $e'); // Debug log
      emit(TrackingAddEditFailure('Image pick error: $e'));
      emit(const TrackingAddEditInitial());
    }
  }

  void _onClearSelectedImage(ClearSelectedImage event, Emitter<TrackingAddEditState> emit) {
    final current = state;
    if (current is TrackingAddEditInitial) {
      print('Clearing selectedImage and imageUrl'); // Debug log
      final newState = current.copyWith(
        newSelectedImage: null,
        imageUrl: '',
        expiryDate: '',
        startDate: '',
        isLoadingImage: false,
      );
      emit(newState);
      print('New state after clear image: $newState');
    } else {
      print('Cannot clear image, state is not TrackingAddEditInitial: $current'); // Debug log
      emit(const TrackingAddEditInitial());
    }
  }


  void _onClearForm (ClearForm event , Emitter<TrackingAddEditState>emit){
    final current = state;
    if (current is TrackingAddEditInitial) {
      print('Clearing form'); // Debug log
      emit(current.copyWith(
        newSelectedImage: null,
        imageUrl: '',
        expiryDate: '',
        startDate: '',
        isLoadingImage: false,
        label: '',
        category:'',
        name: '',
        quantity: '',
        numberId: '',
      ));
    } else {
      print('Cannot clear image, state is not TrackingAddEditInitial: $current'); // Debug log
      emit(const TrackingAddEditInitial());
    }
  }

  // Future<void> _onScanImage(ScanImage event, Emitter<TrackingAddEditState> emit) async {
  //   final current = state;
  //   if (current is TrackingAddEditInitial && current.selectedImage != null) {
  //     print('Scanning image using remote data source: ${current.selectedImage!.path}');
  //     emit(current.copyWith(isLoadingImage: true));
  //
  //     final result = await extractDateFromImageUseCase.execute(current.selectedImage!);
  //
  //     result.fold(
  //           (error) {
  //         print('Date extraction failed: $error');
  //         emit(TrackingAddEditFailure('Failed to extract date: ${error.toString()}'));
  //         emit(current.copyWith(isLoadingImage: false));
  //       },
  //           (extractedDate) {
  //         print('Extracted date: $extractedDate');
  //         emit(current.copyWith(
  //           expiryDate: extractedDate,
  //           startDate: (current.startDate?.isEmpty ?? true) ? extractedDate : current.startDate,
  //           isLoadingImage: false,
  //         ));
  //       },
  //     );
  //   } else {
  //     print('No image selected for scanning.');
  //     emit(TrackingAddEditFailure('No image selected.'));
  //     emit(const TrackingAddEditInitial());
  //   }
  // }

  Future<void> _onScanImage(ScanImage event, Emitter<TrackingAddEditState> emit) async {
    final current = state;

    if (current is! TrackingAddEditInitial || current.selectedImage == null) {
      print('No image selected for scanning or invalid state: $current');
      emit(TrackingAddEditFailure('No image selected.'));
      emit(const TrackingAddEditInitial());
      return;
    }

    print('Scanning image using remote data source: ${current.selectedImage!.path}');
    emit(current.copyWith(isLoadingImage: true));

    final result = await extractDateFromImageUseCase.execute(current.selectedImage!);

    result.fold(
          (error) {
        print('Date extraction failed: $error');
        emit(TrackingAddEditFailure('Failed to extract date: ${error.toString()}'));
        emit(current.copyWith(isLoadingImage: false));
      },
          (extractedDatesString) {
        print('Extracted dates: $extractedDatesString');

        final dates = extractedDatesString
            .split(',')
            .map((d) => d.trim())
            .where((d) => d.isNotEmpty)
            .toList();

        if (dates.isEmpty) {
          emit(current.copyWith(isLoadingImage: false));
          return;
        }

        if (dates.length == 1) {
          emit(current.copyWith(
            expiryDate: dates[0],
            isLoadingImage: false,
          ));
        } else {
          // Optional: sort dates chronologically if format allows
          final sortedDates = List<String>.from(dates)
            ..sort((a, b) => _parseDate(a).compareTo(_parseDate(b)));

          emit(current.copyWith(
            startDate: sortedDates[0],
            expiryDate: sortedDates[1],
            isLoadingImage: false,
          ));
        }
      },
    );
  }

  /// Helper to parse a date string like "19 09 2020" or "FEB/26/21"
  DateTime _parseDate(String dateStr) {
    try {
      if (dateStr.contains('/')) {
        return DateFormat('MMM/dd/yy').parse(dateStr);
      } else {
        return DateFormat('dd MM yyyy').parse(dateStr);
      }
    } catch (_) {
      return DateTime(1900); // Fallback for invalid formats
    }
  }
  Future<void> _onSubmitForm(SubmitForm event, Emitter<TrackingAddEditState> emit) async {
    final current = state;
    if (current is! TrackingAddEditInitial) {
      print('Cannot submit, state is not TrackingAddEditInitial: $current'); // Debug log
      emit(TrackingAddEditFailure('Invalid state for submission'));
      emit(const TrackingAddEditInitial());
      return;
    }

    if ([
      current.name,
      current.numberId,
      current.category,
      current.label,
      current.quantity,
      current.expiryDate,
    ].any((e) => e.trim().isEmpty)) {
      print('Validation failed: Required fields are empty'); // Debug log
      emit(const TrackingAddEditFailure('All required fields must be filled'));
      emit(current.copyWith());
      return;
    }

    final quantity = int.tryParse(current.quantity);
    if (quantity == null) {
      print('Validation failed: Invalid quantity'); // Debug log
      emit(const TrackingAddEditFailure('Quantity must be a valid number'));
      emit(current.copyWith());
      return;
    }

    print('Submitting form: ${current.toString()}'); // Debug log
    emit(TrackingAddEditLoading());

    final result = current.isEditMode
        ? await updateTrackingProductUseCase.execute(
      id: current.id!,
      name: current.name,
      numberId: current.numberId,
      category: current.category,
      label: current.label,
      quantity: quantity,
      startDate: current.startDate?.isEmpty ?? true ? null : current.startDate,
      endDate: current.expiryDate,
      image: current.selectedImage,
    )
        : await addTrackingProductUseCase.execute(
      name: current.name,
      numberId: current.numberId,
      category: current.category,
      label: current.label,
      quantity: quantity,
      startDate: current.startDate?.isEmpty ?? true ? null : current.startDate,
      endDate: current.expiryDate,
      image: current.selectedImage,
    );

    result.fold(
          (error) {
        print('Submit error: $error'); // Debug log
        emit(TrackingAddEditFailure('Error: $error'));
        emit(current.copyWith());
      },
          (product) {
        print('Submit successful: $product'); // Debug log
        emit(TrackingAddEditLoaded(product));
        emit(const TrackingAddEditInitial());
      },
    );
  }
}