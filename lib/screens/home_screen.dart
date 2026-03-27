import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/asset_paths.dart';
import '../core/utils/session_storage.dart';
import '../models/animal.dart';
import '../repositories/animal_repository.dart';
import '../widgets/animal_card.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AnimalRepository _repository = AnimalRepository();
  late Future<List<Animal>> _animalsFuture;

  Future<void> _logout() async {
    await SessionStorage.clearSession();

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _animalsFuture = _repository.getAnimals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AssetPaths.raccoonGif,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppConstants.animalsSectionTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder<List<Animal>>(
                future: _animalsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Ocurrió un error al cargar los animales.'),
                    );
                  }

                  final animals = snapshot.data ?? [];

                  if (animals.isEmpty) {
                    return const Center(
                      child: Text('No hay animales disponibles.'),
                    );
                  }

                  return ListView.builder(
                    itemCount: animals.length,
                    itemBuilder: (context, index) {
                      return AnimalCard(animal: animals[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
