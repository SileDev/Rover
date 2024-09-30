import 'position.dart';
import 'size.dart';

///Modelo para el mapa.

class MarsMap {
  Size size;
  List<Position> obstacles;

  /// Constructor del modelo [MarsMap].
  MarsMap({
    required this.size,
    required this.obstacles,
  });
}
