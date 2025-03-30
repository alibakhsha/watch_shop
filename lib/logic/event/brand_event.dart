// logic/event/brand_event.dart
abstract class BrandEvent {
  const BrandEvent();
}

class FetchBrands extends BrandEvent {
  const FetchBrands();
}