import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';

class BotonApp extends StatelessWidget {
  const BotonApp({
    super.key,
    required this.titulo,
    required this.alPresionar,
    this.lleno = true,
    this.icono,
  });

  final String titulo;
  final VoidCallback? alPresionar;
  final bool lleno;
  final Widget? icono;

  @override
  Widget build(BuildContext context) {
    final activo = alPresionar != null;
    final esquinas = BorderRadius.circular(lleno ? 28 : 14);

    return GestureDetector(
      onTap: alPresionar,
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: esquinas,
          color: lleno ? (activo ? null : Estilos.apagado) : Colors.white,
          gradient: lleno && activo
              ? const LinearGradient(
                  colors: [Estilos.fucsiaBoton, Estilos.violeta],
                )
              : null,
          border: lleno ? null : Border.all(color: Estilos.linea),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icono != null) ...[icono!, const SizedBox(width: 8)],
            Flexible(
              child: Text(
                titulo,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: lleno
                      ? (activo ? Colors.white : Estilos.grisTexto)
                      : Estilos.letras,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
