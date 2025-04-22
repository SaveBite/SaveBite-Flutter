import 'package:equatable/equatable.dart';

class ProductFilterEntity extends Equatable{
  final String? search;
  final String? category;

  ProductFilterEntity({this.search, this.category});

  @override
  // TODO: implement props
  List<Object?> get props => [search , category];
}
