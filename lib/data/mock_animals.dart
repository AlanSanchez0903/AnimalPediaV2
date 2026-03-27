import '../models/animal.dart';

// Datos locales para arrancar el proyecto sin backend.
const List<Animal> mockAnimals = [
  Animal(
    name: 'Mapache',
    scientificName: 'Procyon lotor',
    description:
        'Mamífero omnívoro conocido por su máscara facial y sus patas hábiles.',
    imagePath: 'assets/images/r1.jpg',
  ),
  Animal(
    name: 'Nutria',
    scientificName: 'Lutra lutra',
    description: 'Animal semiacuático muy social y excelente nadador.',
    imagePath: 'assets/images/r3.jpg',
  ),
  Animal(
    name: 'Zorro rojo',
    scientificName: 'Vulpes vulpes',
    description: 'Especie adaptable presente en bosques, praderas y áreas urbanas.',
    imagePath: 'assets/images/r5.jpg',
  ),
];
