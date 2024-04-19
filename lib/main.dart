import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture_demo/app/app.dart';
import 'package:flutter_clean_architecture_demo/app/injector.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  Injector();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  runApp(DevicePreview(
    enabled: false, //!kReleaseMode,
    builder: (context) => const Application()),
  );
}

//TODO Comentar código
//TODO Revisar arquitectura => Casos de uso / managers...
//TODO Documentar Readme