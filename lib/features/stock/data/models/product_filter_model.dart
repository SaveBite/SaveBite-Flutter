import '../../domain/entites/product_filter_entity.dart';

class ProductFilterModel extends ProductFilterEntity {


  ProductFilterModel({super.search, super.category});

  Map<String, String> toQueryParameters() {
    final Map<String, String> params = {};
    if (search != null) params['search'] = search!;
    if (category != null) params['category'] = category!;
    return params;
  }
}
