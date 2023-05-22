import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class CrashlyticsHome extends StatelessWidget {
  const CrashlyticsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Core example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    // Código propenso a errores
                    int result =
                        10 ~/ 0; // División entre cero (genera una excepción)
                    print('Resultado: $result');
                  } catch (e, stackTrace) {
                    // Registra el error junto con información personalizada
                    await FirebaseCrashlytics.instance
                        .recordError(e, stackTrace, information: ['other']);
                  }
                },
                child: const Text('Registrar información'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Registra un evento personalizado en Crashlytics
                  await FirebaseCrashlytics.instance
                      .log('Evento personalizado: myCustomEvent');
                },
                child: const Text('Customizar Error'),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    int result =
                        10 ~/ 0; // División entre cero (genera una excepción)
                    print('Resultado: $result');
                  } catch (e, stackTrace) {
                    // Personaliza el informe de error antes de enviarlo a Crashlytics
                    final errorDetails =
                        FlutterErrorDetails(exception: e, stack: stackTrace);
                    FirebaseCrashlytics.instance
                        .recordFlutterError(errorDetails);
                  }
                },
                child: const Text('Personalizar Informe Error'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Genera un error intencional para probar Crashlytics
                  FirebaseCrashlytics.instance.crash();
                },
                child: const Text('Generar error'),
              ),
            ],
          ),
        ));
  }
}
