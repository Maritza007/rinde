import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/rinde_theme.dart';
import '../widgets/logo_rinde.dart';

// Pantalla de carga: se muestra 2 segundos y abre la pantalla siguiente
class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.siguiente});

  // Pantalla a la que se pasa después de la carga
  final Widget siguiente;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _temporizador;

  @override
  void initState() {
    super.initState();
    _temporizador = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => widget.siguiente),
      );
    });
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RindeColors.verdeOscuro,
      body: SafeArea(
        // Ancho completo para que todo quede centrado
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const LogoRinde(ancho: 260),
              const Spacer(),
              const SizedBox(
                width: 140,
                child: LinearProgressIndicator(
                  color: RindeColors.lima,
                  backgroundColor: Colors.white24,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'CARGANDO DATOS DE HOY...',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 1,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}