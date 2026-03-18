import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/joke_provider.dart';

class JokeView extends StatefulWidget {
  const JokeView({super.key});

  @override
  State<JokeView> createState() => _JokeViewState();
}

class _JokeViewState extends State<JokeView> {
  @override
  void initState() {
    super.initState();

    // ignore: use_build_context_synchronously
    Future.microtask(() => context.read<JokeProvider>().fetchRandomJoke());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBC02D),
        title: const Text(
          '😂 Joke of the Day',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<JokeProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: provider.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : provider.error != null
                            ? Column(
                                children: [
                                  const Icon(Icons.error_outline,
                                      color: Colors.red, size: 50),
                                  const SizedBox(height: 12),
                                  Text(
                                    provider.error!,
                                    style: const TextStyle(color: Colors.red),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : provider.currentJoke == null
                                ? const Text('Prem el botó per veure un acudit!')
                                : Column(
                                    children: [
                                      const Icon(Icons.format_quote,
                                          size: 40, color: Color(0xFFFBC02D)),
                                      const SizedBox(height: 16),

                                      Text(
                                        provider.currentJoke!.setup,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(),
                                      const SizedBox(height: 20),

                                      Text(
                                        provider.currentJoke!.punchline,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFFF57F17),
                                          fontStyle: FontStyle.italic,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 12),

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFBC02D)
                                              // ignore: deprecated_member_use
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: const Color(0xFFFBC02D)),
                                        ),
                                        child: Text(
                                          provider.currentJoke!.type,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFFF57F17),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                  ),
                ),
                const SizedBox(height: 40),

                ElevatedButton.icon(
                  onPressed: provider.isLoading
                      ? null
                      : () => context.read<JokeProvider>().fetchRandomJoke(),
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Nou acudit!',
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBC02D),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}