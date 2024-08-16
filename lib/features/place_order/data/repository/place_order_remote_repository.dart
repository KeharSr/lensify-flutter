// Repository Implementation
import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/place_order/domain/entity/place_order_entity.dart';
import 'package:final_assignment/features/place_order/domain/repository/place_order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/remote/place_order_remote_data_source.dart';

final placeOrderRemoteRepositoryProvider =
    Provider<PlaceOrderRemoteRepository>((ref) {
  final placeOrderRemoteDataSource =
      ref.watch(placeOrderRemoteDataSourceProvider);
  return PlaceOrderRemoteRepository(
      placeOrderRemoteDataSource: placeOrderRemoteDataSource);
});

class PlaceOrderRemoteRepository implements IPlaceOrderRepository {
  final PlaceOrderRemoteDataSource placeOrderRemoteDataSource;

  PlaceOrderRemoteRepository({required this.placeOrderRemoteDataSource});

  @override
  Future<Either<Failure, String>> placeOrder(PlaceOrderEntity entity) async {
    return placeOrderRemoteDataSource.placeOrder(entity);
  }

  @override
  Future<Either<Failure, List<PlaceOrderEntity>>> getOrderByUser() async {
    return placeOrderRemoteDataSource.getOrderByUser();
  }
}
