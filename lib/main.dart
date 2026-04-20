import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opn_form/form_renderer.dart';

void main() {
  runApp( ProviderScope(child: MyApp(), observers: [_AppProviderObserver()],));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Form Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Opn Form Dynamic Rendering'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const DynamicForm(),
    );
  }
}



class _AppProviderObserver extends ProviderObserver {
  @override
  void didUpdateProvider(
      ProviderBase provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    debugPrint('UPDATED: ${provider.name ?? provider.runtimeType}');
    debugPrint('Old: $previousValue');
    debugPrint('New: $newValue');
  }

  @override
  void didDisposeProvider(
      ProviderBase provider,
      ProviderContainer container,
      ) {
    debugPrint('DISPOSED: ${provider.name ?? provider.runtimeType}');
  }

  @override
  void didAddProvider(
      ProviderBase provider,
      Object? value,
      ProviderContainer container,
      ) {
    debugPrint('ADDED: ${provider.name ?? provider.runtimeType}');
    debugPrint('Value: $value');

    // Log who triggered this provider initialization
    final stackTrace = StackTrace.current.toString();
    final lines = stackTrace.split('\n');

    // Filter only your app's lines, skip framework/riverpod internals
    final appLines = lines.where((line) =>
    line.contains('package:mre') &&        // ← your app package
        !line.contains('provider_observer') &&  // skip this file itself
        !line.contains('riverpod')              // skip riverpod internals
    ).take(5).toList();                       // take top 5 relevant frames

    if (appLines.isNotEmpty) {
      debugPrint('↳ Triggered from:');
      for (final line in appLines) {
        debugPrint('  $line');
      }
    } else {
      debugPrint('↳ Triggered from: (framework/startup)');
    }
  }
}