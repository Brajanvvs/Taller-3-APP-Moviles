import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taller_corte_3/estilos.dart';

class CasillaCodigo extends StatelessWidget {
  const CasillaCodigo({
    super.key,
    required this.controlador,
    required this.foco,
    required this.alEscribir,
  });

  final TextEditingController controlador;
  final FocusNode foco;
  final ValueChanged<String> alEscribir;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: 58,
      child: TextField(
        controller: controlador,
        focusNode: foco,
        onChanged: alEscribir,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Estilos.letras,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Estilos.linea),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Estilos.linea),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Estilos.violeta, width: 1.6),
          ),
        ),
      ),
    );
  }
}
