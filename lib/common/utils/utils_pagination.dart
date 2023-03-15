import 'package:delivery_codefactory/common/provider/provider_pagination.dart';
import 'package:flutter/cupertino.dart';

class UtilsPagination {
  static void paginate({
    required ScrollController scrollController,
    required ProviderPagination providerPagination,
  }) {
    if (scrollController.offset > scrollController.position.maxScrollExtent - 300) {
      providerPagination.paginate(fetchMore: true);
    }
  }
}
