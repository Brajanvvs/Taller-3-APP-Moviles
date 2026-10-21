import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/Campo.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final txtCorreo = TextEditingController();
  final txtClave = TextEditingController();
  bool claveOculta = true;
  String? fallaCorreo;

  bool get correoBien {
    return RegExp(
      r'^[\w.\-]+@[\w\-]+\.[A-Za-z]{2,}$',
    ).hasMatch(txtCorreo.text.trim());
  }

  bool get sesionLista {
    return correoBien && txtClave.text.isNotEmpty;
  }

  @override
  void dispose() {
    txtCorreo.dispose();
    txtClave.dispose();
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

  void entrar() {
    if (!sesionLista) return;

    Navigator.of(context).pushNamedAndRemoveUntil(
      "/inicio",
      (_) => false,
      arguments: {"correo": txtCorreo.text.trim()},
    );
  }

  void avisarNoDisponible() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Funcionalidad no disponible")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final datos = ModalRoute.of(context)?.settings.arguments;
    final aviso = datos is Map ? datos["aviso"] as String? : null;

    return FondoPantalla(
      hijo: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Estilos.fucsia, Estilos.violeta],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.lock_outline,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Bienvenido de nuevo",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Estilos.letras,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Inicia sesión para continuar",
              style: TextStyle(color: Estilos.grisTexto, fontSize: 15),
            ),
            if (aviso != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Estilos.exitoClaro,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  aviso,
                  style: const TextStyle(
                    color: Estilos.exito,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 28),
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
              pista: "Ingresa tu contraseña",
              controlador: txtClave,
              ocultar: claveOculta,
              alOjo: () {
                setState(() {
                  claveOculta = !claveOculta;
                });
              },
              alEscribir: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/recuperar");
                },
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(
                    color: Estilos.violeta,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),
            BotonApp(
              titulo: "Iniciar sesión",
              alPresionar: sesionLista ? entrar : null,
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Expanded(child: Divider(color: Estilos.linea)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    "o continúa con",
                    style: TextStyle(color: Estilos.grisTexto),
                  ),
                ),
                Expanded(child: Divider(color: Estilos.linea)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: BotonApp(
                    titulo: "Google",
                    lleno: false,
                    alPresionar: avisarNoDisponible,
                    icono: const Text(
                      "G",
                      style: TextStyle(
                        color: Color(0xFFEA4335),
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: BotonApp(
                    titulo: "Apple",
                    lleno: false,
                    alPresionar: avisarNoDisponible,
                    icono: const Icon(Icons.apple, color: Estilos.letras),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    "¿No tienes cuenta? ",
                    style: TextStyle(color: Estilos.grisTexto),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/registro");
                    },
                    child: const Text(
                      "Regístrate",
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
