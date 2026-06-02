import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../services/hive_service.dart';
import '../../core/constants/enums.dart';

class OrderRepository {
  final HiveService _hiveService;

  OrderRepository(this._hiveService);

  List<OrderModel> getAll() {
    return _hiveService.orderBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<OrderModel> getForClient(String clientId) {
    return _hiveService.orderBox.values
        .where((o) => o.clientId == clientId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  OrderModel? getById(String id) {
    return _hiveService.orderBox.values
        .where((o) => o.id == id)
        .firstOrNull;
  }

  List<OrderModel> getByStatus(OrderStatus status) {
    return _hiveService.orderBox.values
        .where((o) => o.status == status.name)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<OrderModel> getOverdue() {
    return _hiveService.orderBox.values.where((o) => o.isOverdue).toList()
      ..sort((a, b) => a.dueDate!.compareTo(b.dueDate!));
  }

  Future<void> save(OrderModel order) async {
    await _hiveService.orderBox.put(order.id, order);
  }

  Future<void> delete(String id) async {
    await _hiveService.orderBox.delete(id);
  }

  Future<void> deleteForClient(String clientId) async {
    final ids = _hiveService.orderBox.values
        .where((o) => o.clientId == clientId)
        .map((o) => o.id)
        .toList();
    for (final id in ids) {
      await _hiveService.orderBox.delete(id);
    }
  }

  int get count => _hiveService.orderBox.length;

  int get pendingCount => _hiveService.orderBox.values
      .where((o) => o.status == OrderStatus.pending.name || o.status == OrderStatus.inProgress.name)
      .length;

  double get totalRevenue => _hiveService.orderBox.values
      .fold(0.0, (sum, o) => sum + o.advanceAmount);
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return OrderRepository(hiveService);
});
