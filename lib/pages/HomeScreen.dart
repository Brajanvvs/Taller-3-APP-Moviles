import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';
import 'package:taller_corte_3/widgets/BotonApp.dart';
import 'package:taller_corte_3/widgets/FondoPantalla.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final datos =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final correo = datos?["correo"] ?? "";

    return FondoPantalla(
      hijo: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Estilos.violeta.withValues(alpha: 0.12),
              ),
              child: const Icon(Icons.person, size: 52, color: Estilos.violeta),
            ),
            const SizedBox(height: 20),
            const Text(
              "¡Bienvenido!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Estilos.letras,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              correo,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Estilos.grisTexto, fontSize: 16),
            ),
            const SizedBox(height: 32),
            BotonApp(
              titulo: "Cerrar sesión",
              alPresionar: () {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil("/", (_) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
