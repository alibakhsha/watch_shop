
import 'package:watch_shop/core/model/brand.dart';

abstract class BrandState {
  const BrandState();
}

class BrandInitial extends BrandState {
  const BrandInitial();
}

class BrandLoading extends BrandState {
  const BrandLoading();
}

class BrandLoaded extends BrandState {
  final List<BrandModel> brands;

  const BrandLoaded(this.brands);
}

class BrandError extends BrandState {
  final String message;

  const BrandError(this.message);
}