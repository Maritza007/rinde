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

/// Fecha en formato dd/mm/aaaa.
String formatoFecha(DateTime fecha) {
  final dia = fecha.day.toString().padLeft(2, '0');
  final mes = fecha.month.toString().padLeft(2, '0');
  return '$dia/$mes/${fecha.year}';
}

/// Horas sin decimales si son enteras (8 -> "8"), con un decimal si no (7.5 -> "7.5").
String formatoHoras(double horas) {
  return horas == horas.roundToDouble()
      ? horas.toStringAsFixed(0)
      : horas.toStringAsFixed(1);
}