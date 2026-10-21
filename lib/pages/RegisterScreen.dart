import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/Campo.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final txtNombre = TextEditingController();
  final txtCorreo = TextEditingController();
  final txtClave = TextEditingController();
  final txtRepetir = TextEditingController();
  bool claveOculta = true;
  bool repetirOculta = true;
  bool marcoTerminos = false;
  String? fallaCorreo;

  bool get correoBien {
    return RegExp(
      r'^[\w.\-]+@[\w\-]+\.[A-Za-z]{2,}$',
    ).hasMatch(txtCorreo.text.trim());
  }

  bool get clavesIguales {
    return txtClave.text.isNotEmpty && txtClave.text == txtRepetir.text;
  }

  bool get registroListo {
    return txtNombre.text.trim().isNotEmpty &&
        correoBien &&
        clavesIguales &&
        marcoTerminos;
  }

  String? get fallaRepetir {
    if (txtRepetir.text.isEmpty) return null;
    if (txtClave.text == txtRepetir.text) return null;
    return "Las claves no son iguales";
  }

  @override
  void dispose() {
    txtNombre.dispose();
    txtCorreo.dispose();
    txtClave.dispose();
    txtRepetir.dispose();
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

  void crearCuenta() {
    if (!registroListo) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      "/inicio",
      (_) => false,
      arguments: {"correo": txtCorreo.text.trim()},
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
            const SizedBox(height: 18),
            const Text(
              "Crea tu cuenta",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Estilos.letras,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Completa tus datos para empezar",
              style: TextStyle(color: Estilos.grisTexto, fontSize: 15),
            ),
            const SizedBox(height: 24),
            Campo(
              titulo: "Nombre completo",
              pista: "Tu nombre",
              controlador: txtNombre,
              alEscribir: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            Campo(
              titulo: "Correo electrónico",
              pista: "nombre@correo.com",
              controlador: txtCorreo,
              tipoTeclado: TextInputType.emailAddress,
              mensaje: fallaCorreo,
              alEscribir: revisarCorreo,
            ),
            const SizedBox(height: 16),
            Campo(
              titulo: "Contraseña",
              pista: "Crea una contraseña",
              controlador: txtClave,
              ocultar: claveOculta,
              alOjo: () {
                setState(() {
                  claveOculta = !claveOculta;
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
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: marcoTerminos,
                  activeColor: Estilos.violeta,
                  onChanged: (valor) {
                    setState(() {
                      marcoTerminos = valor ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text(
                      "Acepto los términos y condiciones y la Política de privacidad",
                      style: TextStyle(color: Estilos.letras, height: 1.3),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            BotonApp(
              titulo: "Crear cuenta",
              alPresionar: registroListo ? crearCuenta : null,
            ),
            const SizedBox(height: 24),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "¿Ya tienes cuenta? ",
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
