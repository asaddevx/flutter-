import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/measurement_model.dart';
import '../services/hive_service.dart';

class MeasurementRepository {
  final HiveService _hiveService;

  MeasurementRepository(this._hiveService);

  List<MeasurementModel> getAll() {
    return _hiveService.measurementBox.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  List<MeasurementModel> getForClient(String clientId) {
    return _hiveService.measurementBox.values
        .where((m) => m.clientId == clientId)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  MeasurementModel? getById(String id) {
    return _hiveService.measurementBox.values
        .where((m) => m.id == id)
        .firstOrNull;
  }

  MeasurementModel? getDefaultForClient(String clientId) {
    return _hiveService.measurementBox.values
        .where((m) => m.clientId == clientId && m.isDefault)
        .firstOrNull;
  }

  Future<void> save(MeasurementModel measurement) async {
    if (measurement.isDefault) {
      await _clearDefaultForClient(measurement.clientId, excludeId: measurement.id);
    }
    await _hiveService.measurementBox.put(measurement.id, measurement);
  }

  Future<void> _clearDefaultForClient(String clientId, {String? excludeId}) async {
    final toUpdate = _hiveService.measurementBox.values
        .where((m) => m.clientId == clientId && m.isDefault && m.id != excludeId)
        .toList();
    for (final m in toUpdate) {
      await _hiveService.measurementBox.put(m.id, m.copyWith(isDefault: false));
    }
  }

  Future<void> delete(String id) async {
    await _hiveService.measurementBox.delete(id);
  }

  Future<void> deleteForClient(String clientId) async {
    final ids = _hiveService.measurementBox.values
        .where((m) => m.clientId == clientId)
        .map((m) => m.id)
        .toList();
    for (final id in ids) {
      await _hiveService.measurementBox.delete(id);
    }
  }
}

final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return MeasurementRepository(hiveService);
});
