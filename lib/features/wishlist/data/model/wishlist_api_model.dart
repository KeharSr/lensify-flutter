import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/product/data/model/product_api_model.dart';
import 'package:final_assignment/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_api_model.g.dart';

// provider
final wishlistApiModelProvider = Provider((ref) => WishlistApiModel.empty());

@JsonSerializable()
class WishlistApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? userId;
  final ProductApiModel? productId;

  WishlistApiModel(
      {required this.id, required this.userId, required this.productId});

  const WishlistApiModel.empty()
      : id = '',
        userId = '',
        productId = null;

  factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);

  // To Entity
  WishlistEntity toEntity() {
    return WishlistEntity(
        id: id, userId: userId, productId: productId!.toEntity());
  }

  // To Model
  factory WishlistApiModel.fromEntity(WishlistEntity entity) {
    return WishlistApiModel(
        id: entity.id,
        userId: entity.userId,
        productId: ProductApiModel.fromEntity(entity.productId!));
  }

  // To List
  List<WishlistEntity> toEntityList(List<WishlistApiModel> wishlists) {
    return wishlists.map((wishlist) => wishlist.toEntity()).toList();
  }

  // From List
  List<WishlistApiModel> fromEntityList(List<WishlistEntity> wishlists) {
    return wishlists
        .map((wishlist) => WishlistApiModel.fromEntity(wishlist))
        .toList();
  }

  @override
  List<Object?> get props => [id, userId, productId];
}
