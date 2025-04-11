import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:watch_shop/core/model/cart.dart';
import 'package:watch_shop/logic/event/cart_event.dart';
import 'package:watch_shop/logic/state/cart_state.dart';
import 'package:flutter/cupertino.dart';

import '../../services/api_sevice.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  CartBloc(this.apiService) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<IncreaseCartItemQuantity>(_onIncreaseCartItemQuantity);
    on<DecreaseCartItemQuantity>(_onDecreaseCartItemQuantity);
    on<DeleteCartItem>(_onDeleteCartItem);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      debugPrint('Token: $token');
      if (token == null) {
        emit(CartError(message: 'توکن یافت نشد. لطفاً دوباره وارد شوید.'));
        return;
      }

      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await apiService.post(
        '/public/api/v1/user_cart',
        data: FormData.fromMap({}),
      );

      debugPrint('LoadCart Response Status: ${response.statusCode}');
      debugPrint('LoadCart Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data;
        debugPrint('LoadCart Result: ${data['result']}');
        if (data['result'] == true) {
          final cart = CartModel.fromJson(data);
          emit(
            CartLoaded(
              cartItems: cart.items,
              totalPrice: cart.totalWithDiscountPrice,
            ),
          );
        } else {
          emit(
            CartError(message: data['message'] ?? 'خطا در بارگذاری سبد خرید'),
          );
        }
      } else {
        emit(
          CartError(
            message: 'خطا در بارگذاری سبد خرید: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      debugPrint('LoadCart Error: $e');
      emit(CartError(message: 'خطا در بارگذاری سبد خرید: $e'));
    }
  }

  Future<void> _onAddProductToCart(
    AddProductToCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      debugPrint('Token: $token');
      if (token == null) {
        emit(CartError(message: 'توکن یافت نشد. لطفاً دوباره وارد شوید.'));
        return;
      }

      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await apiService.post(
        '/public/api/v1/add_to_cart',
        data: FormData.fromMap({
          'product_id': event.productId,
          'quantity': event.quantity,
        }),
      );

      debugPrint('AddProductToCart Response Status: ${response.statusCode}');
      debugPrint('AddProductToCart Response Data: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data;
        debugPrint('AddProductToCart Result: ${data['result']}');
        if (data['result'] == true) {
          add(LoadCart());
        } else {
          emit(
            CartError(message: data['message'] ?? 'خطا در افزودن به سبد خرید'),
          );
        }
      } else {
        emit(
          CartError(
            message: 'خطا در افزودن به سبد خرید: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      debugPrint('AddProductToCart Error: $e');
      emit(CartError(message: 'خطا در افزودن به سبد خرید: $e'));
    }
  }

  Future<void> _onIncreaseCartItemQuantity(
    IncreaseCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      debugPrint('Token: $token');
      if (token == null) {
        emit(CartError(message: 'توکن یافت نشد. لطفاً دوباره وارد شوید.'));
        return;
      }

      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await apiService.post(
        '/public/api/v1/add_to_cart',
        data: FormData.fromMap({'product_id': event.productId, 'quantity': 1}),
      );

      debugPrint(
        'IncreaseCartItemQuantity Response Status: ${response.statusCode}',
      );
      debugPrint('IncreaseCartItemQuantity Response Data: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data;
        debugPrint('IncreaseCartItemQuantity Result: ${data['result']}');
        if (data['result'] == true) {
          add(LoadCart());
        } else {
          emit(CartError(message: data['message'] ?? 'خطا در افزایش تعداد'));
        }
      } else {
        emit(CartError(message: 'خطا در افزایش تعداد: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('IncreaseCartItemQuantity Error: $e');
      emit(CartError(message: 'خطا در افزایش تعداد: $e'));
    }
  }

  Future<void> _onDecreaseCartItemQuantity(
    DecreaseCartItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      debugPrint('Token: $token');
      if (token == null) {
        emit(CartError(message: 'توکن یافت نشد. لطفاً دوباره وارد شوید.'));
        return;
      }

      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await apiService.post(
        '/public/api/v1/remove_from_cart',
        data: FormData.fromMap({'product_id': event.productId, 'quantity': 1}),
      );

      debugPrint(
        'DecreaseCartItemQuantity Response Status: ${response.statusCode}',
      );
      debugPrint('DecreaseCartItemQuantity Response Data: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data;
        debugPrint('DecreaseCartItemQuantity Result: ${data['result']}');
        if (data['result'] == true) {
          add(LoadCart());
        } else {
          emit(CartError(message: data['message'] ?? 'خطا در کاهش تعداد'));
        }
      } else {
        emit(CartError(message: 'خطا در کاهش تعداد: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('DecreaseCartItemQuantity Error: $e');
      emit(CartError(message: 'خطا در کاهش تعداد: $e'));
    }
  }

  Future<void> _onDeleteCartItem(
    DeleteCartItem event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final token = await secureStorage.read(key: 'token');
      debugPrint('Token: $token');
      if (token == null) {
        emit(CartError(message: 'توکن یافت نشد. لطفاً دوباره وارد شوید.'));
        return;
      }

      apiService.dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await apiService.post(
        '/public/api/v1/delete_from_cart',
        data: FormData.fromMap({'product_id': event.productId}),
      );

      debugPrint('DeleteCartItem Response Status: ${response.statusCode}');
      debugPrint('DeleteCartItem Response Data: ${response.data}');

      if (response.statusCode == 201) {
        final data = response.data;
        debugPrint('DeleteCartItem Result: ${data['result']}');
        if (data['result'] == true) {
          add(LoadCart());
        } else {
          emit(CartError(message: data['message'] ?? 'خطا در حذف محصول'));
        }
      } else {
        emit(CartError(message: 'خطا در حذف محصول: ${response.statusCode}'));
      }
    } catch (e) {
      debugPrint('DeleteCartItem Error: $e');
      emit(CartError(message: 'خطا در حذف محصول: $e'));
    }
  }
}
