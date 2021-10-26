// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'purchase_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PurchaseStateTearOff {
  const _$PurchaseStateTearOff();

  _PurchaseState call(
      {required LoadingStatus status,
      required List<Product> products,
      required Cart cart}) {
    return _PurchaseState(
      status: status,
      products: products,
      cart: cart,
    );
  }
}

/// @nodoc
const $PurchaseState = _$PurchaseStateTearOff();

/// @nodoc
mixin _$PurchaseState {
  LoadingStatus get status => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;
  Cart get cart => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PurchaseStateCopyWith<PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseStateCopyWith<$Res> {
  factory $PurchaseStateCopyWith(
          PurchaseState value, $Res Function(PurchaseState) then) =
      _$PurchaseStateCopyWithImpl<$Res>;
  $Res call({LoadingStatus status, List<Product> products, Cart cart});
}

/// @nodoc
class _$PurchaseStateCopyWithImpl<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  _$PurchaseStateCopyWithImpl(this._value, this._then);

  final PurchaseState _value;
  // ignore: unused_field
  final $Res Function(PurchaseState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? products = freezed,
    Object? cart = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
    ));
  }
}

/// @nodoc
abstract class _$PurchaseStateCopyWith<$Res>
    implements $PurchaseStateCopyWith<$Res> {
  factory _$PurchaseStateCopyWith(
          _PurchaseState value, $Res Function(_PurchaseState) then) =
      __$PurchaseStateCopyWithImpl<$Res>;
  @override
  $Res call({LoadingStatus status, List<Product> products, Cart cart});
}

/// @nodoc
class __$PurchaseStateCopyWithImpl<$Res>
    extends _$PurchaseStateCopyWithImpl<$Res>
    implements _$PurchaseStateCopyWith<$Res> {
  __$PurchaseStateCopyWithImpl(
      _PurchaseState _value, $Res Function(_PurchaseState) _then)
      : super(_value, (v) => _then(v as _PurchaseState));

  @override
  _PurchaseState get _value => super._value as _PurchaseState;

  @override
  $Res call({
    Object? status = freezed,
    Object? products = freezed,
    Object? cart = freezed,
  }) {
    return _then(_PurchaseState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
      products: products == freezed
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      cart: cart == freezed
          ? _value.cart
          : cart // ignore: cast_nullable_to_non_nullable
              as Cart,
    ));
  }
}

/// @nodoc

class _$_PurchaseState extends _PurchaseState {
  const _$_PurchaseState(
      {required this.status, required this.products, required this.cart})
      : super._();

  @override
  final LoadingStatus status;
  @override
  final List<Product> products;
  @override
  final Cart cart;

  @override
  String toString() {
    return 'PurchaseState(status: $status, products: $products, cart: $cart)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PurchaseState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.products, products) &&
            (identical(other.cart, cart) || other.cart == cart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(products), cart);

  @JsonKey(ignore: true)
  @override
  _$PurchaseStateCopyWith<_PurchaseState> get copyWith =>
      __$PurchaseStateCopyWithImpl<_PurchaseState>(this, _$identity);
}

abstract class _PurchaseState extends PurchaseState {
  const factory _PurchaseState(
      {required LoadingStatus status,
      required List<Product> products,
      required Cart cart}) = _$_PurchaseState;
  const _PurchaseState._() : super._();

  @override
  LoadingStatus get status;
  @override
  List<Product> get products;
  @override
  Cart get cart;
  @override
  @JsonKey(ignore: true)
  _$PurchaseStateCopyWith<_PurchaseState> get copyWith =>
      throw _privateConstructorUsedError;
}
