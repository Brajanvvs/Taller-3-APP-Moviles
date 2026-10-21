import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';

class Campo extends StatelessWidget {
  const Campo({
    super.key,
    required this.titulo,
    required this.controlador,
    this.pista,
    this.ocultar = false,
    this.alOjo,
    this.mensaje,
    this.tipoTeclado,
    this.alEscribir,
  });

  final String titulo;
  final TextEditingController controlador;
  final String? pista;
  final bool ocultar;
  final VoidCallback? alOjo;
  final String? mensaje;
  final TextInputType? tipoTeclado;
  final ValueChanged<String>? alEscribir;

  @override
  Widget build(BuildContext context) {
    final colorLinea = mensaje == null ? Estilos.linea : Estilos.rojo;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Estilos.letras,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controlador,
          obscureText: ocultar,
          keyboardType: tipoTeclado,
          onChanged: alEscribir,
          style: const TextStyle(color: Estilos.letras, fontSize: 15),
          decoration: InputDecoration(
            hintText: pista,
            hintStyle: const TextStyle(color: Estilos.grisTexto),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            suffixIcon: alOjo == null
                ? null
                : IconButton(
                    onPressed: alOjo,
                    icon: Icon(
                      ocultar
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Estilos.grisTexto,
                    ),
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: colorLinea),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: colorLinea),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: mensaje == null ? Estilos.violeta : Estilos.rojo,
                width: 1.5,
              ),
            ),
          ),
        ),
        if (mensaje != null) ...[
          const SizedBox(height: 6),
          Text(
            mensaje!,
            style: const TextStyle(color: Estilos.rojo, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
