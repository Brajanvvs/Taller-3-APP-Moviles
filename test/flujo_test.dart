import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taller_corte_3/main.dart';
import 'package:taller_corte_3/widgets/CasillaCodigo.dart';

void main() {
  testWidgets('recorre login registro y recuperacion', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const MainApp());

    await tester.enterText(find.byType(TextField).at(0), 'correo-malo');
    await tester.pump();
    expect(
      find.text('El correo no es válido (usuario@dominio.com)'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField).at(0), 'luis@correo.com');
    await tester.enterText(find.byType(TextField).at(1), '1234');
    await tester.pump();
    await tester.tap(find.text('Iniciar sesión'));
    await tester.pumpAndSettle();
    expect(find.text('¡Bienvenido!'), findsOneWidget);
    expect(find.text('luis@correo.com'), findsOneWidget);

    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Regístrate'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Luis Perez');
    await tester.enterText(find.byType(TextField).at(1), 'luis@correo.com');
    await tester.enterText(find.byType(TextField).at(2), 'secreto');
    await tester.enterText(find.byType(TextField).at(3), 'otra');
    await tester.pump();
    expect(find.text('Las claves no son iguales'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(3), 'secreto');
    await tester.pump();
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('Crear cuenta'));
    await tester.pumpAndSettle();
    expect(find.text('luis@correo.com'), findsOneWidget);

    await tester.tap(find.text('Cerrar sesión'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('¿Olvidaste tu contraseña?'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'luis@correo.com');
    await tester.pump();
    await tester.tap(find.text('Enviar código'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Verifica tu correo'), findsOneWidget);
    expect(find.text('Reenviar código en 00:45'), findsOneWidget);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Reenviar código en 00:44'), findsOneWidget);

    for (var i = 0; i < 4; i++) {
      await tester.enterText(
        find.descendant(
          of: find.byType(CasillaCodigo).at(i),
          matching: find.byType(EditableText),
        ),
        '${i + 1}',
      );
      await tester.pump();
    }

    await tester.tap(find.text('Siguiente'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Código verificado'), findsOneWidget);

    final campos = find.byType(EditableText).hitTestable();
    await tester.enterText(campos.at(0), 'Clave123');
    await tester.enterText(campos.at(1), 'Clave123');
    await tester.pump();
    await tester.tap(find.text('Restablecer contraseña'));
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido de nuevo'), findsOneWidget);
    expect(find.text('La contraseña se actualizó'), findsOneWidget);
  });
}
