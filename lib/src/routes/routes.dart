import 'package:llama/src/pages/api_page.dart';
import 'package:llama/src/pages/billetera_page.dart';
import 'package:llama/src/pages/formulario_page.dart';
import 'package:llama/src/pages/lugares_page.dart';
import 'package:llama/src/pages/mapa_page.dart';
import 'package:llama/src/pages/podcast_page.dart';
import 'package:llama/src/pages/secondFormPage_page.dart';
import 'package:flutter/cupertino.dart';

Map<String, WidgetBuilder> obtenerRutas() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => ApiPage(),
    'mapa': (BuildContext context) => MapaPage(),
    'billetera': (BuildContext context) => BilleteraPage(),
    'podcast': (BuildContext context) => PodcastPage(),
    'lugares': (BuildContext context) => LugaresPage(),
    'formulario_dos': (BuildContext context) => SecondFormPage(),
  };
}
