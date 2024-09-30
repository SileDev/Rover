import 'dart:io';
import 'enums/cardinal_points.dart';
import 'models/position.dart';

/// Clase que proporciona métodos para obtener entradas del usuario desde la consola
/// relacionadas con el tamaño del mapa, obstáculos y configuraciones iniciales del rover.

class ConsoleLogger {
  /// Solicita al usuario el ancho del mapa y lo devuelve.
  /// La entrada debe ser un número entero sin decimales.
  int getMapwidth() {
    print("-Indique el ancho del mapa (Número sin decimales)");
    late int mapwidth;
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        try {
          mapwidth = int.parse(input);
          break;
        } catch (e) {
          print("Ingrese un valor válido (Número sin decimales)");
        }
      } else {
        print("Ingrese un valor");
      }
    }
    return mapwidth;
  }

  /// Solicita al usuario el alto del mapa y lo devuelve.
  /// La entrada debe ser un número entero sin decimales.
  int getMapHeight() {
    print("-Indique el alto del mapa (Número sin decimales)");
    late int mapHeight;
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        try {
          mapHeight = int.parse(input);
          break;
        } catch (e) {
          print("Ingrese un valor válido (Número sin decimales)");
        }
      } else {
        print("Ingrese un valor");
      }
    }

    return mapHeight;
  }

  /// Solicita al usuario las coordenadas de los obstáculos en el mapa y devuelve una lista de posiciones.
  /// La entrada debe ser en el formato "x, y". Para finalizar la entrada de obstáculos, el usuario debe escribir 'done'.
  List<Position> getMapObstacles() {
    print(
        "-Indique las coordenadas de los obstáculos (Formato: x, y); Digite 'done' cuando haya finalizado.");
    List<Position> obstacles = [];
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        if (input.toUpperCase() == "DONE") {
          break;
        } else {
          try {
            List<String> points = input.split(",");
            Position newPosition = Position(
              x: int.parse(points[0]),
              y: int.parse(points[1]),
            );

            obstacles.add(newPosition);
          } catch (e) {
            print("Ingrese una coordenada válida (x, y)");
          }
        }
      } else {
        print("Ingrese un valor");
      }
    }

    return obstacles;
  }

  /// Solicita al usuario las coordenadas iniciales del rover y devuelve la posición.
  /// La entrada debe ser en el formato "x, y".
  Position getRoverInitialPosition() {
    print("-Indique las coordenadas iniciales del Rover (Formato: x, y)");
    late Position initialPosition;
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        try {
          List<String> points = input.split(",");
          initialPosition = Position(
            x: int.parse(points[0]),
            y: int.parse(points[1]),
          );

          break;
        } catch (e) {
          print("Ingrese una coordenada válida (x, y)");
        }
      } else {
        print("Ingrese un valor");
      }
    }

    return initialPosition;
  }

  /// Solicita al usuario la orientación inicial del rover y devuelve la dirección cardinal.
  /// Las opciones válidas son 'N' (Norte), 'E' (Este), 'S' (Sur), y 'W' (Oeste).
  CardinalPoints getRoverInitialDirection() {
    print(
        "-Indique la orientación inicial del Rover\n> Norte: 'N'\n> Sur: 'S'\n> Este: 'E'\n> Oeste: 'W'");
    late CardinalPoints initialDirection;
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        bool validEntry = true;

        switch (input.toUpperCase()) {
          case "N":
            initialDirection = CardinalPoints.North;
            break;
          case "E":
            initialDirection = CardinalPoints.East;
            break;
          case "S":
            initialDirection = CardinalPoints.South;
            break;
          case "W":
            initialDirection = CardinalPoints.West;
            break;
          default:
            print(
                "Ingrese una orientación válida\n> Norte: 'N'\n> Sur: 'S'\n> Este: 'E'\n> Oeste: 'W'");
            validEntry = false;
        }

        if (validEntry) {
          break;
        }
      } else {
        print("Ingrese un valor");
      }
    }

    return initialDirection;
  }

  /// Solicita al usuario las instrucciones para el movimiento del rover y las devuelve como una cadena.
  /// Las instrucciones válidas son 'F' (Avanzar), 'R' (Girar a la derecha), y 'L' (Girar a la izquierda).
  String getRoverInstructions() {
    print(
        "Introduzca todas las instrucciones del Rover en una sola línea\n> Avanzar: 'F'\n> Girar a la derecha: 'R'\n> Girar a la izquierda: 'L'");
    late String instructions;
    while (true) {
      String? input = stdin.readLineSync();
      if (input != null) {
        instructions = input;
        break;
      } else {
        print("Ingrese un valor");
      }
    }

    return instructions;
  }
}
