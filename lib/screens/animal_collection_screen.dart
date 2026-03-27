import 'package:flutter/material.dart';

import '../models/animal.dart';
import '../repositories/animal_repository.dart';
import '../widgets/animal_card.dart';

class AnimalCollectionScreen extends StatefulWidget {
  const AnimalCollectionScreen({
    super.key,
    this.showOnlyDiscovered = false,
    this.showOnlyUndiscovered = false,
  });

  static const String routeName = '/animal-collection';

  final bool showOnlyDiscovered;
  final bool showOnlyUndiscovered;

  @override
  State<AnimalCollectionScreen> createState() => _AnimalCollectionScreenState();
}

class _AnimalCollectionScreenState extends State<AnimalCollectionScreen> {
  final AnimalRepository _repository = AnimalRepository();
  List<Animal> _animals = <Animal>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAnimals();
  }

  Future<void> _loadAnimals() async {
    final animals = await _repository.getAnimals();

    if (!mounted) {
      return;
    }

    setState(() {
      _animals = animals;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.showOnlyDiscovered
        ? 'Animales descubiertos'
        : widget.showOnlyUndiscovered
            ? 'Animales por descubrir'
            : 'Colección de animales';

    final animalsToShow = widget.showOnlyDiscovered
        ? _animals.where((animal) => animal.descubierto).toList()
        : widget.showOnlyUndiscovered
            ? _animals.where((animal) => !animal.descubierto).toList()
            : _animals;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : animalsToShow.isEmpty
              ? _EmptyCollectionState(showOnlyUndiscovered: widget.showOnlyUndiscovered)
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: animalsToShow.length,
                  itemBuilder: (context, index) {
                    return AnimalCard(animal: animalsToShow[index]);
                  },
                ),
    );
  }
}

class _EmptyCollectionState extends StatelessWidget {
  const _EmptyCollectionState({required this.showOnlyUndiscovered});

  final bool showOnlyUndiscovered;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          showOnlyUndiscovered
              ? '¡Gran trabajo! Ya no tienes animales pendientes por descubrir.'
              : 'Aún no tienes animales descubiertos.\nVe al mapa para iniciar tu exploración.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70),
        ),
      ),
    );
  }
}
