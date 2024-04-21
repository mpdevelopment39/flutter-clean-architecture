import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_demo/app/app.dart';
import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  //* Leemos las variables de entorno para poder hacer uso de ellas en todo el proyecto
  await dotenv.load(fileName: ".env");
  //* Inyectamos dependencias 
  Injector();
  
  //* Seteamos la orientación del dispositivo por defecto vertical.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  //* Utilizamos el paquete de device_preview para poder hacer pruebas de interfaz en cualquier dispositivo
  runApp(DevicePreview(
    enabled: false, //!kReleaseMode,
    builder: (context) => const Application()),
  );
}

//TODO Cambiar icono
//TODO Añadir splash
//TODO Añadir tests
//TODO Añadir gestión de errores