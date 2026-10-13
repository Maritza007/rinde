class Gasto {
  const Gasto({required this.categoria, required this.monto});

  final String categoria;
  final double monto;
}

class RegistroJornada {
  const RegistroJornada({
    required this.fecha,
    this.horas,
    this.servicios,
    this.ingresos,
    this.gastos = const [],
  });

  final DateTime fecha;
  final double? horas; // null = no indicado
  final int? servicios; // null = no indicado
  final double? ingresos; // null = no indicado
  final List<Gasto> gastos;

  double get totalGastos => gastos.fold(0, (suma, gasto) => suma + gasto.monto);

  /// Ingresos menos gastos registrados. Es null si no hay ingresos.
  double? get gananciaNeta {
    final ingresosRegistrados = ingresos;
    if (ingresosRegistrados == null) return null;
    return ingresosRegistrados - totalGastos;
  }

  /// Ganancia neta dividida entre las horas. Es null si faltan datos.
  double? get gananciaPorHora {
    final neta = gananciaNeta;
    final horasRegistradas = horas;
    if (neta == null || horasRegistradas == null || horasRegistradas <= 0) {
      return null;
    }
    return neta / horasRegistradas;
  }
}