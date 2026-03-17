import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/tmb_provider.dart';
import '../model/tmb_models.dart';

class TmbView extends StatefulWidget {
  const TmbView({super.key});

  @override
  State<TmbView> createState() => _TmbViewState();
}

class _TmbViewState extends State<TmbView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _paradaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(() {
      context.read<TmbProvider>().fetchLinies();
      context.read<TmbProvider>().fetchParades();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _paradaController.dispose();
    super.dispose();
  }

  Color _hexToColor(String hex) {
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        title: const Text(
          'TMB Barcelona',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.yellow,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.directions_bus), text: 'Línies'),
            Tab(icon: Icon(Icons.place), text: 'Parades'),
            Tab(icon: Icon(Icons.schedule), text: 'Horaris'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _LiniesTab(),
          _ParadesTab(),
          _HorarisTab(paradaController: _paradaController),
        ],
      ),
    );
  }
}

class _LiniesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TmbProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingLinies) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null && provider.linies.isEmpty) {
          return Center(child: Text('Error: ${provider.error}',
              style: const TextStyle(color: Colors.red)));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.linies.length,
          itemBuilder: (context, index) {
            final linia = provider.linies[index];
            return _LiniaCard(linia: linia);
          },
        );
      },
    );
  }
}

class _LiniaCard extends StatelessWidget {
  final BusLinia linia;
  const _LiniaCard({required this.linia});

  Color _hexToColor(String hex) {
    try {
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _hexToColor(linia.colorLinia);
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            linia.nomLinia,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
        title: Text(
          linia.descLinia,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Línia ${linia.codiLinia}'),
        trailing: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _ParadesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TmbProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingParades) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.error != null && provider.parades.isEmpty) {
          return Center(child: Text('Error: ${provider.error}',
              style: const TextStyle(color: Colors.red)));
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: provider.parades.length,
          itemBuilder: (context, index) {
            final parada = provider.parades[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFF003366),
                  child: Icon(Icons.place, color: Colors.white, size: 20),
                ),
                title: Text(
                  parada.nomParada,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${parada.adreca}\n${parada.nomDistricte}'),
                isThreeLine: true,
                trailing: Text(
                  '#${parada.codiParada}',
                  style: const TextStyle(
                    color: Color(0xFF003366),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _HorarisTab extends StatelessWidget {
  final TextEditingController paradaController;
  const _HorarisTab({required this.paradaController});

  @override
  Widget build(BuildContext context) {
    return Consumer<TmbProvider>(
      builder: (context, provider, _) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: paradaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Codi de parada',
                        hintText: 'Ex: 1265',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003366),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: provider.isLoadingArrivals
                        ? null
                        : () {
                            final codi =
                                int.tryParse(paradaController.text.trim());
                            if (codi != null) {
                              context
                                  .read<TmbProvider>()
                                  .fetchArrivals(codi);
                            }
                          },
                    child: provider.isLoadingArrivals
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (provider.codiParadaActual != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Parada #${provider.codiParadaActual}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF003366),
                    ),
                  ),
                ),

              if (provider.error != null)
                Text('Error: ${provider.error}',
                    style: const TextStyle(color: Colors.red)),

              if (!provider.isLoadingArrivals && provider.arrivals.isEmpty &&
                  provider.codiParadaActual != null &&
                  provider.error == null)
                const Text('No hi ha autobusos pròximament.'),

              Expanded(
                child: ListView.builder(
                  itemCount: provider.arrivals.length,
                  itemBuilder: (context, index) {
                    final arrival = provider.arrivals[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: const Color(0xFF003366),
                          child: Text(
                            arrival.line,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        title: Text(
                          arrival.destination,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: arrival.tInMin <= 2
                                ? Colors.green
                                : const Color(0xFF003366),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            arrival.textCa,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}