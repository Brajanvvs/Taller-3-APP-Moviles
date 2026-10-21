import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/Campo.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final txtNueva = TextEditingController();
  final txtRepetir = TextEditingController();
  bool nuevaOculta = true;
  bool repetirOculta = true;

  String get nuevaClave => txtNueva.text;

  bool get tieneOcho => nuevaClave.length >= 8;
  bool get tieneMayus => RegExp(r'[A-Z]').hasMatch(nuevaClave);
  bool get tieneNumero => RegExp(r'[0-9]').hasMatch(nuevaClave);

  bool get clavesIguales {
    return nuevaClave.isNotEmpty && nuevaClave == txtRepetir.text;
  }

  bool get cambioListo {
    return tieneOcho && tieneMayus && tieneNumero && clavesIguales;
  }

  String? get fallaRepetir {
    if (txtRepetir.text.isEmpty) return null;
    if (nuevaClave == txtRepetir.text) return null;
    return "Las claves no son iguales";
  }

  @override
  void dispose() {
    txtNueva.dispose();
    txtRepetir.dispose();
    super.dispose();
  }

  void guardarClave() {
    if (!cambioListo) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      "/",
      (_) => false,
      arguments: {"aviso": "La contraseña se actualizó"},
    );
  }

  @override
  Widget build(BuildContext context) {
    return FondoPantalla(
      hijo: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.arrow_back, color: Estilos.letras),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Estilos.exitoClaro,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: Estilos.exito, size: 16),
                  SizedBox(width: 6),
                  Text(
                    "Código verificado",
                    style: TextStyle(
                      color: Estilos.exito,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Crea una nueva contraseña",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Estilos.letras,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Tu nueva contraseña debe cumplir los requisitos.",
              style: TextStyle(
                color: Estilos.grisTexto,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Campo(
              titulo: "Nueva contraseña",
              pista: "Escribe la nueva contraseña",
              controlador: txtNueva,
              ocultar: nuevaOculta,
              alOjo: () {
                setState(() {
                  nuevaOculta = !nuevaOculta;
                });
              },
              alEscribir: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Campo(
              titulo: "Confirmar contraseña",
              pista: "Repite la contraseña",
              controlador: txtRepetir,
              ocultar: repetirOculta,
              mensaje: fallaRepetir,
              alOjo: () {
                setState(() {
                  repetirOculta = !repetirOculta;
                });
              },
              alEscribir: (_) => setState(() {}),
            ),
            const SizedBox(height: 18),
            _Regla(cumplida: tieneOcho, texto: "Mínimo 8 caracteres"),
            const SizedBox(height: 8),
            _Regla(cumplida: tieneMayus, texto: "Una letra mayúscula"),
            const SizedBox(height: 8),
            _Regla(cumplida: tieneNumero, texto: "Un número"),
            const SizedBox(height: 24),
            BotonApp(
              titulo: "Restablecer contraseña",
              alPresionar: cambioListo ? guardarClave : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _Regla extends StatelessWidget {
  const _Regla({required this.cumplida, required this.texto});

  final bool cumplida;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          cumplida ? Icons.check_circle : Icons.circle_outlined,
          color: cumplida ? Estilos.exito : Estilos.grisTexto,
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          texto,
          style: TextStyle(
            color: cumplida ? Estilos.exito : Estilos.grisTexto,
            fontWeight: cumplida ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
