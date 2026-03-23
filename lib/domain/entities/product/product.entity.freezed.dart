// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductEntity {
  String get id => throw _privateConstructorUsedError;
  @Assert('name.isNotEmpty', 'name cannot be empty')
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @Assert('price >= 0', 'price cannot be negative')
  double get price => throw _privateConstructorUsedError;
  @Assert('quantity >= 0', 'quantity cannot be negative')
  int get quantity => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductEntityCopyWith<ProductEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEntityCopyWith<$Res> {
  factory $ProductEntityCopyWith(
          ProductEntity value, $Res Function(ProductEntity) then) =
      _$ProductEntityCopyWithImpl<$Res, ProductEntity>;
  @useResult
  $Res call(
      {String id,
      @Assert('name.isNotEmpty', 'name cannot be empty') String name,
      String? description,
      @Assert('price >= 0', 'price cannot be negative') double price,
      @Assert('quantity >= 0', 'quantity cannot be negative') int quantity,
      File? image});
}

/// @nodoc
class _$ProductEntityCopyWithImpl<$Res, $Val extends ProductEntity>
    implements $ProductEntityCopyWith<$Res> {
  _$ProductEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? quantity = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductEntityImplCopyWith<$Res>
    implements $ProductEntityCopyWith<$Res> {
  factory _$$ProductEntityImplCopyWith(
          _$ProductEntityImpl value, $Res Function(_$ProductEntityImpl) then) =
      __$$ProductEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @Assert('name.isNotEmpty', 'name cannot be empty') String name,
      String? description,
      @Assert('price >= 0', 'price cannot be negative') double price,
      @Assert('quantity >= 0', 'quantity cannot be negative') int quantity,
      File? image});
}

/// @nodoc
class __$$ProductEntityImplCopyWithImpl<$Res>
    extends _$ProductEntityCopyWithImpl<$Res, _$ProductEntityImpl>
    implements _$$ProductEntityImplCopyWith<$Res> {
  __$$ProductEntityImplCopyWithImpl(
      _$ProductEntityImpl _value, $Res Function(_$ProductEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? price = null,
    Object? quantity = null,
    Object? image = freezed,
  }) {
    return _then(_$ProductEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$ProductEntityImpl extends _ProductEntity {
  const _$ProductEntityImpl(
      {required this.id,
      @Assert('name.isNotEmpty', 'name cannot be empty') required this.name,
      required this.description,
      @Assert('price >= 0', 'price cannot be negative') required this.price,
      @Assert('quantity >= 0', 'quantity cannot be negative')
      required this.quantity,
      required this.image})
      : super._();

  @override
  final String id;
  @override
  @Assert('name.isNotEmpty', 'name cannot be empty')
  final String name;
  @override
  final String? description;
  @override
  @Assert('price >= 0', 'price cannot be negative')
  final double price;
  @override
  @Assert('quantity >= 0', 'quantity cannot be negative')
  final int quantity;
  @override
  final File? image;

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, description: $description, price: $price, quantity: $quantity, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, price, quantity, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      __$$ProductEntityImplCopyWithImpl<_$ProductEntityImpl>(this, _$identity);
}

abstract class _ProductEntity extends ProductEntity {
  const factory _ProductEntity(
      {required final String id,
      @Assert('name.isNotEmpty', 'name cannot be empty')
      required final String name,
      required final String? description,
      @Assert('price >= 0', 'price cannot be negative')
      required final double price,
      @Assert('quantity >= 0', 'quantity cannot be negative')
      required final int quantity,
      required final File? image}) = _$ProductEntityImpl;
  const _ProductEntity._() : super._();

  @override
  String get id;
  @override
  @Assert('name.isNotEmpty', 'name cannot be empty')
  String get name;
  @override
  String? get description;
  @override
  @Assert('price >= 0', 'price cannot be negative')
  double get price;
  @override
  @Assert('quantity >= 0', 'quantity cannot be negative')
  int get quantity;
  @override
  File? get image;
  @override
  @JsonKey(ignore: true)
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
