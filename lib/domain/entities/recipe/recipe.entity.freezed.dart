// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe.entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecipeEntity {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  String get preparationTime => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<ProductEntity> get ingredients => throw _privateConstructorUsedError;
  File? get image => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RecipeEntityCopyWith<RecipeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeEntityCopyWith<$Res> {
  factory $RecipeEntityCopyWith(
          RecipeEntity value, $Res Function(RecipeEntity) then) =
      _$RecipeEntityCopyWithImpl<$Res, RecipeEntity>;
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String preparationTime,
      String? description,
      List<ProductEntity> ingredients,
      File? image});
}

/// @nodoc
class _$RecipeEntityCopyWithImpl<$Res, $Val extends RecipeEntity>
    implements $RecipeEntityCopyWith<$Res> {
  _$RecipeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? preparationTime = null,
    Object? description = freezed,
    Object? ingredients = null,
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
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      preparationTime: null == preparationTime
          ? _value.preparationTime
          : preparationTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<ProductEntity>,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeEntityImplCopyWith<$Res>
    implements $RecipeEntityCopyWith<$Res> {
  factory _$$RecipeEntityImplCopyWith(
          _$RecipeEntityImpl value, $Res Function(_$RecipeEntityImpl) then) =
      __$$RecipeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      String preparationTime,
      String? description,
      List<ProductEntity> ingredients,
      File? image});
}

/// @nodoc
class __$$RecipeEntityImplCopyWithImpl<$Res>
    extends _$RecipeEntityCopyWithImpl<$Res, _$RecipeEntityImpl>
    implements _$$RecipeEntityImplCopyWith<$Res> {
  __$$RecipeEntityImplCopyWithImpl(
      _$RecipeEntityImpl _value, $Res Function(_$RecipeEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? preparationTime = null,
    Object? description = freezed,
    Object? ingredients = null,
    Object? image = freezed,
  }) {
    return _then(_$RecipeEntityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      preparationTime: null == preparationTime
          ? _value.preparationTime
          : preparationTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      ingredients: null == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<ProductEntity>,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as File?,
    ));
  }
}

/// @nodoc

class _$RecipeEntityImpl extends _RecipeEntity {
  const _$RecipeEntityImpl(
      {required this.id,
      required this.name,
      required this.price,
      required this.preparationTime,
      required this.description,
      required final List<ProductEntity> ingredients,
      required this.image})
      : _ingredients = ingredients,
        super._();

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  final String preparationTime;
  @override
  final String? description;
  final List<ProductEntity> _ingredients;
  @override
  List<ProductEntity> get ingredients {
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ingredients);
  }

  @override
  final File? image;

  @override
  String toString() {
    return 'RecipeEntity(id: $id, name: $name, price: $price, preparationTime: $preparationTime, description: $description, ingredients: $ingredients, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.preparationTime, preparationTime) ||
                other.preparationTime == preparationTime) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            (identical(other.image, image) || other.image == image));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, price, preparationTime,
      description, const DeepCollectionEquality().hash(_ingredients), image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeEntityImplCopyWith<_$RecipeEntityImpl> get copyWith =>
      __$$RecipeEntityImplCopyWithImpl<_$RecipeEntityImpl>(this, _$identity);
}

abstract class _RecipeEntity extends RecipeEntity {
  const factory _RecipeEntity(
      {required final String id,
      required final String name,
      required final double price,
      required final String preparationTime,
      required final String? description,
      required final List<ProductEntity> ingredients,
      required final File? image}) = _$RecipeEntityImpl;
  const _RecipeEntity._() : super._();

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  String get preparationTime;
  @override
  String? get description;
  @override
  List<ProductEntity> get ingredients;
  @override
  File? get image;
  @override
  @JsonKey(ignore: true)
  _$$RecipeEntityImplCopyWith<_$RecipeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
