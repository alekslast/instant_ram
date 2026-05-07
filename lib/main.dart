import 'package:flutter/material.dart';
import 'package:flutter_tanstack_query/flutter_tanstack_query.dart';
import 'package:instant_ram/services/audio_provider.dart';
import 'package:instant_ram/services/post_provider.dart';
import 'package:instant_ram/widgets/widget_tree.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await QueryCache.instance.initialize();
  await NetworkPolicy.instance.initialize();
  AppLifecycleManager.instance.initialize();

  runApp(const InstantRamApp());
}

class InstantRamApp extends StatelessWidget {
  const InstantRamApp({super.key});

  @override
  Widget build(BuildContext context) {
    final queryClient = QueryClient(
      cache: QueryCache.instance,
      networkPolicy: NetworkPolicy.instance,

      onSuccess: () => debugPrint('Query executed successfully!'),
      onError: (error) => debugPrint('Query error: $error'),
      onRefreshError: (error) => debugPrint('Refresh error: $error'),
    );

    return QueryClientProvider(
      client: queryClient,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PostProvider()),
          ChangeNotifierProvider(create: (context) => AudioProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'InstantRam',
          theme: ThemeData(
            colorScheme: .fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.dark,
            ),
            splashFactory: NoSplash.splashFactory,
            navigationBarTheme: NavigationBarThemeData(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ),
          home: const WidgetTree(),
        ),
      ),
    );
  }
}
