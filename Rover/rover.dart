import '../enums/cardinal_points.dart';
import '../models/position.dart';
import '../models/size.dart';

/// Clase que representa un Rover que puede moverse en un mapa.

class Rover {
  /// Posición actual del rover en el mapa.
  Position position;

  /// Dirección actual en la que está orientado el rover.
  CardinalPoints direction;

  /// Lista de las direcciones cardinales en el orden de movimiento.
  List<CardinalPoints> _directions = [
    CardinalPoints.North,
    CardinalPoints.East,
    CardinalPoints.South,
    CardinalPoints.West,
  ];

  /// Constructor de la clase [Rover].
  /// Requiere una [position] inicial y una [direction] para la orientación.
  Rover({
    required this.position,
    required this.direction,
  });

  /// Calcula la posición futura del rover basado en su dirección actual y el tamaño del mapa [mapSize].
  Position _calculateFuturePosition({
    required Size mapSize,
  }) {
    late int posX = position.x;
    late int posY = position.y;

    switch (direction) {
      case CardinalPoints.North:
        posY = (position.y + 1) % mapSize.height;
        break;
      case CardinalPoints.East:
        posX = (position.x + 1) % mapSize.width;
        break;
      case CardinalPoints.South:
        posY = (position.y - 1) % mapSize.height;
        break;
      case CardinalPoints.West:
        posX = (position.x - 1) % mapSize.width;
        break;
      default:
        break;
    }

    if (posX < 0) posX += mapSize.width;
    if (posX > mapSize.width - 1) posX -= mapSize.width;
    if (posY < 0) posY += mapSize.height;
    if (posY > mapSize.height - 1) posY -= mapSize.height;

    return Position(x: posX, y: posY);
  }

  /// Evalúa si la posición futura [futurePosition] coincide con alguna de las posiciones de los obstáculos [obstacles].
  bool _evluateIfIsObstacle({
    required Position futurePosition,
    required List<Position> obstacles,
  }) {
    return obstacles.any(
      (obstacle) =>
          obstacle.x == futurePosition.x && obstacle.y == futurePosition.y,
    );
  }

  /// Ejecuta el movimiento del rover hacia una nueva posición [newPosition].
  void _executeMovement({
    required Position newPosition,
  }) {
    position = newPosition;
  }

  /// Gira el rover hacia la izquierda.
  void _turnLeft() {
    int directionIndex = _directions.indexOf(direction);
    direction = _directions[
        (directionIndex - 1 + _directions.length) % _directions.length];
  }

  /// Gira el rover hacia la derecha.
  void _turnRight() {
    int directionIndex = _directions.indexOf(direction);
    direction = _directions[
        (directionIndex + 1 + _directions.length) % _directions.length];
  }

  /// Ejecuta una secuencia de comandos [commands] para mover el rover dentro del tamaño del mapa [mapSize],
  /// evitando obstáculos [obstacles].
  void executeCommands({
    required Size mapSize,
    required String commands,
    required List<Position> obstacles,
  }) {
    for (var command in commands.toUpperCase().split('')) {
      switch (command) {
        case "F":
          print("Se solicitó avanzar");

          Position futurePosition = _calculateFuturePosition(mapSize: mapSize);

          if (!_evluateIfIsObstacle(
            futurePosition: futurePosition,
            obstacles: obstacles,
          )) {
            _executeMovement(newPosition: futurePosition);
            print(
                "Se realizó el desplazamiento hacia la posición {x: ${position.x}, y: ${position.y}}");
          } else {
            print(
                "Secuencia abortada, hay un obstáculo en la posición {x: ${futurePosition.x}, y: ${futurePosition.y}}");
            return;
          }
          break;
        case "L":
          _turnLeft();
          print(
              "Se realizó un giro hacia la izquierda, la nueva orientación es '${describeOrientation()}'");
          break;
        case "R":
          _turnRight();
          print(
              "Se realizó un giro hacia la derecha, la nueva orientación es '${describeOrientation()}'");
          break;
        default:
          print(
              "Secuencia abortada, se halló un comando desconocido '$command'");
          return;
      }
    }
  }

  /// Describe la orientación actual del rover en texto legible.
  String describeOrientation() {
    switch (direction) {
      case CardinalPoints.North:
        return "Norte";
      case CardinalPoints.East:
        return "Este";
      case CardinalPoints.South:
        return "Sur";
      case CardinalPoints.West:
        return "Oeste";
      default:
        return "Desconocido";
    }
  }
}
