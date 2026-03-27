import 'package:shared_preferences/shared_preferences.dart';

/// Persistencia local mínima para registrar animales descubiertos.
///
/// Se guarda únicamente el listado de ids en SharedPreferences.
class AnimalDiscoveryStorage {
  AnimalDiscoveryStorage._();

  static const String _discoveredAnimalsKey = 'discovered_animals_ids_v1';

  static Future<Set<String>> loadDiscoveredIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_discoveredAnimalsKey) ?? <String>[];
    return ids.toSet();
  }

  static Future<void> saveDiscoveredIds(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_discoveredAnimalsKey, ids.toList()..sort());
  }
}
