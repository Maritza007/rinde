import 'package:flutter/material.dart';

import 'screens/splash_page.dart';
import 'theme/rinde_theme.dart';

void main() {
  runApp(const RentabilidadApp());
}

class RentabilidadApp extends StatelessWidget {
  const RentabilidadApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentabilidad Inteligente',
      debugShowCheckedModeBanner: false,
      theme: construirTemaRinde(),
      home: const SplashPage(siguiente: HomePage()),
    );
  }
}

/// Convierte un número en pesos con puntos de miles. Ej: 130000 -> $130.000
String formatoPesos(num valor) {
  final texto = valor.round().abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < texto.length; i++) {
    final restantes = texto.length - i;
    buffer.write(texto[i]);
    if (restantes > 1 && restantes % 3 == 1) buffer.write('.');
  }
  final signo = valor < 0 ? '-' : '';
  return '$signo\$${buffer.toString()}';
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controlador = TextEditingController();

  // DATOS DE EJEMPLO (solo para esta primera versión demostrativa).
  static const double _ingresos = 130000;
  static const double _gastos = 28000;
  static const double _horas = 8;

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  void _mostrarAviso(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  void _interpretar() {
    if (_controlador.text.trim().isEmpty) {
      _mostrarAviso('Escribe primero cómo te fue hoy.');
      return;
    }
    _mostrarAviso(
      'Texto recibido. La interpretación con IA se conectará en una próxima etapa.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final gananciaNeta = _ingresos - _gastos;
    final gananciaPorHora = gananciaNeta / _horas;
    final estilos = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Rentabilidad Inteligente')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Resumen de hoy', style: estilos.titleLarge),
                ),
                const Chip(label: Text('Datos de ejemplo')),
              ],
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _FilaResumen(
                      etiqueta: 'Ingresos',
                      valor: formatoPesos(_ingresos),
                    ),
                    _FilaResumen(
                      etiqueta: 'Gastos',
                      valor: formatoPesos(_gastos),
                    ),
                    const Divider(),
                    _FilaResumen(
                      etiqueta: 'Ganancia neta',
                      valor: formatoPesos(gananciaNeta),
                      destacado: true,
                    ),
                    _FilaResumen(
                      etiqueta: 'Horas trabajadas',
                      valor: '${_horas.toStringAsFixed(0)} h',
                    ),
                    _FilaResumen(
                      etiqueta: 'Ganancia por hora',
                      valor: formatoPesos(gananciaPorHora),
                      destacado: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Cuéntame cómo te fue hoy', style: estilos.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _controlador,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ej: Hoy trabajé 8 horas, hice 15 domicilios, gané \$130.000 y gasté \$28.000 en gasolina',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: _interpretar,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Interpretar con IA'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _mostrarAviso('Historial: próximamente.'),
                    icon: const Icon(Icons.history),
                    label: const Text('Historial'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _mostrarAviso('Estadísticas: próximamente.'),
                    icon: const Icon(Icons.bar_chart),
                    label: const Text('Estadísticas'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FilaResumen extends StatelessWidget {
  const _FilaResumen({
    required this.etiqueta,
    required this.valor,
    this.destacado = false,
  });

  final String etiqueta;
  final String valor;
  final bool destacado;

  @override
  Widget build(BuildContext context) {
    final estilo = destacado
        ? Theme.of(context).textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold)
        : Theme.of(context).textTheme.bodyLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: estilo),
          Text(valor, style: estilo),
        ],
      ),
    );
  }
}
