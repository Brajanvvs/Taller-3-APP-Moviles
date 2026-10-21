import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/Campo.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {
  final txtCorreo = TextEditingController();
  String? fallaCorreo;

  bool get correoBien {
    return RegExp(
      r'^[\w.\-]+@[\w\-]+\.[A-Za-z]{2,}$',
    ).hasMatch(txtCorreo.text.trim());
  }

  @override
  void dispose() {
    txtCorreo.dispose();
    super.dispose();
  }

  void revisarCorreo(String valor) {
    setState(() {
      if (valor.trim().isEmpty || correoBien) {
        fallaCorreo = null;
      } else {
        fallaCorreo = "El correo no es válido (usuario@dominio.com)";
      }
    });
  }

  void mandarCodigo() {
    if (!correoBien) return;

    Navigator.of(
      context,
    ).pushNamed("/codigo", arguments: {"correo": txtCorreo.text.trim()});
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
            const SizedBox(height: 28),
            Center(
              child: Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  color: Estilos.violeta.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.mail_outline,
                  color: Estilos.violeta,
                  size: 34,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "¿Olvidaste tu contraseña?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Estilos.letras,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ingresa el correo con el que te registraste y te enviaremos un código para recuperarla.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Estilos.grisTexto,
                fontSize: 15,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            Campo(
              titulo: "Correo electrónico",
              pista: "nombre@correo.com",
              controlador: txtCorreo,
              tipoTeclado: TextInputType.emailAddress,
              mensaje: fallaCorreo,
              alEscribir: revisarCorreo,
            ),
            const SizedBox(height: 22),
            BotonApp(
              titulo: "Enviar código",
              alPresionar: correoBien ? mandarCodigo : null,
            ),
            const SizedBox(height: 28),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "¿La recordaste? ",
                    style: TextStyle(color: Estilos.grisTexto),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Inicia sesión",
                      style: TextStyle(
                        color: Estilos.violeta,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
