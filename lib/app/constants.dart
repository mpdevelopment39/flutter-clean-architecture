//* Routes
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String homeRoute = 'home';
const String detailRoute = 'detail';

//* Assets
const String assetsImages = 'assets/images';
const String assetsAnimations = 'assets/animations';
const String assetsFonts = 'assets/fonts';

final String movieDBApiKey = dotenv.env['MOVIEDB_API_KEY'] ?? '';

