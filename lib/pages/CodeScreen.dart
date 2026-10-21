import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/CasillaCodigo.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class CodeScreen extends StatefulWidget {
  const CodeScreen({super.key});

  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final cajas = List.generate(4, (_) => TextEditingController());
  final focos = List.generate(4, (_) => FocusNode());
  Timer? reloj;
  int restante = 45;

  String get codigoArmado => cajas.map((caja) => caja.text).join();

  bool get codigoListo => codigoArmado.length == 4;

  @override
  void initState() {
    super.initState();
    reloj = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || restante == 0) return;
      setState(() {
        restante--;
      });
    });
  }

  @override
  void dispose() {
    reloj?.cancel();
    for (final caja in cajas) {
      caja.dispose();
    }
    for (final foco in focos) {
      foco.dispose();
    }
    super.dispose();
  }

  String textoReloj(int total) {
    final minutos = (total ~/ 60).toString().padLeft(2, "0");
    final segundos = (total % 60).toString().padLeft(2, "0");
    return "$minutos:$segundos";
  }

  void alDigito(int posicion, String valor) {
    if (valor.isNotEmpty && posicion < 3) {
      focos[posicion + 1].requestFocus();
    }
    if (valor.isEmpty && posicion > 0) {
      focos[posicion - 1].requestFocus();
    }
    setState(() {});
  }

  void reiniciarReloj() {
    setState(() {
      restante = 45;
    });
  }

  void seguir() {
    if (!codigoListo) return;
    Navigator.of(context).pushNamed("/clave-nueva");
  }

  @override
  Widget build(BuildContext context) {
    final datos =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final correo = datos?["correo"] ?? "";

    return FondoPantalla(
      hijo: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back, color: Estilos.letras),
              ),
            ),
            const SizedBox(height: 28),
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Estilos.violeta.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.mark_email_read_outlined,
                color: Estilos.violeta,
                size: 34,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Verifica tu correo",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Estilos.letras,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Enviamos un código de 4 dígitos a\n$correo",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Estilos.grisTexto,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var i = 0; i < 4; i++)
                  CasillaCodigo(
                    controlador: cajas[i],
                    foco: focos[i],
                    alEscribir: (valor) => alDigito(i, valor),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            restante == 0
                ? GestureDetector(
                    onTap: reiniciarReloj,
                    child: const Text(
                      "Reenviar código",
                      style: TextStyle(
                        color: Estilos.violeta,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                : Text(
                    "Reenviar código en ${textoReloj(restante)}",
                    style: const TextStyle(color: Estilos.grisTexto),
                  ),
            const SizedBox(height: 28),
            BotonApp(
              titulo: "Siguiente",
              alPresionar: codigoListo ? seguir : null,
            ),
          ],
        ),
      ),
    );
  }
}
