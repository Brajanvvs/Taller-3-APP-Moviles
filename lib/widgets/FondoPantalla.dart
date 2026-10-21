import 'package:flutter/material.dart';
import 'package:taller_corte_3/estilos.dart';

class FondoPantalla extends StatelessWidget {
  const FondoPantalla({super.key, required this.hijo});

  final Widget hijo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, medidas) {
            final ancho = medidas.maxWidth > 430 ? 430.0 : medidas.maxWidth;

            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: ancho,
                height: medidas.maxHeight,
                child: Stack(
                  children: [
                    const Positioned.fill(child: _Decorado()),
                    Positioned.fill(child: hijo),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Decorado extends StatelessWidget {
  const _Decorado();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          _bola(
            140,
            Estilos.fucsia.withValues(alpha: 0.45),
            top: -50,
            right: -40,
          ),
          _bola(
            78,
            Estilos.violeta.withValues(alpha: 0.28),
            top: 36,
            right: 28,
          ),
          _anillo(54, Estilos.violeta, top: 18, left: -16),
          _cuadrado(22, Estilos.naranja, top: 130, right: 36),
          _bola(
            96,
            Estilos.naranja.withValues(alpha: 0.40),
            top: 250,
            right: -36,
          ),
          _bola(
            130,
            Estilos.celesteClaro.withValues(alpha: 0.90),
            bottom: -20,
            left: -46,
          ),
          _bola(
            72,
            Estilos.naranja.withValues(alpha: 0.45),
            bottom: 36,
            left: 28,
          ),
          _bola(
            110,
            Estilos.violeta.withValues(alpha: 0.22),
            bottom: -30,
            right: -24,
          ),
          _anillo(46, Estilos.celeste, bottom: 110, left: 70),
          _cuadrado(18, Estilos.fucsia, bottom: 150, right: 24),
        ],
      ),
    );
  }

  Widget _bola(
    double medida,
    Color color, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: medida,
        height: medida,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }

  Widget _anillo(
    double medida,
    Color color, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: medida,
        height: medida,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color.withValues(alpha: 0.7), width: 7),
        ),
      ),
    );
  }

  Widget _cuadrado(
    double medida,
    Color color, {
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: medida,
        height: medida,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
