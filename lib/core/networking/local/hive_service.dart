import 'package:final_assignment/app/constants/hive_table_constants.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/product/data/model/product_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(ProductHiveModelAdapter());
  }

  Future<void> addUser(AuthHiveModel user) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<List<AuthHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<AuthHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
        (element) => element.email == email && element.password == password);
    box.close();
    return user;
  }

  static addProducts(List<ProductHiveModel> models) async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    await box.clear();
    await box.addAll(models);
    box.close();
  }

  Future<List<ProductHiveModel>> getProducts() async {
    var box =
        await Hive.openBox<ProductHiveModel>(HiveTableConstant.productBox);
    var products = box.values.toList();
    box.close();
    return products;
  }
}
