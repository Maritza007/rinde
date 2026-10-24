import 'package:flutter/material.dart';

// Logo de Rinde para usar en cualquier pantalla
class LogoRinde extends StatelessWidget {
  const LogoRinde({super.key, this.ancho = 200});

  final double ancho;

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/logo_rinde.png', width: ancho);
  }
}
