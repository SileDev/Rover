import 'console_logger.dart';
import 'models/mars_map.dart';
import 'models/size.dart';
import 'rover/rover.dart';

/// Función principal que inicia el proceso de configuración y ejecución del Rover.

void main() {
  print("\Hola, vamos a usar tu Rover.");

  // Instancia de ConsoleLogger para manejar las entradas del usuario.
  ConsoleLogger _consoleLogger = ConsoleLogger();

  print("\nConfiguración del mapa:");
  MarsMap map = MarsMap(
    size: Size(
      width: _consoleLogger.getMapwidth(), // Solicita el ancho del mapa.
      height: _consoleLogger.getMapHeight(), // Solicita el alto del mapa.
    ),
    obstacles: _consoleLogger
        .getMapObstacles(), // Solicita las coordenadas de los obstáculos.
  );

  print("\nConfiguración del Rover:");
  Rover rover = Rover(
    position: _consoleLogger
        .getRoverInitialPosition(), // Solicita la posición inicial del rover.
    direction: _consoleLogger
        .getRoverInitialDirection(), // Solicita la dirección inicial del rover.
  );

  // Solicita las instrucciones para mover el rover.
  String roverCommands = _consoleLogger.getRoverInstructions();

  print("\nEjecución\n");
  rover.executeCommands(
    mapSize: map.size, // Tamaño del mapa donde se moverá el rover.
    commands: roverCommands, // Instrucciones para mover el rover.
    obstacles: map.obstacles, // Lista de obstáculos a evitar.
  );
}
