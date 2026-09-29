import 'package:flutter/material.dart';

void main() {
  runApp(const RekenmachineApp());
}

class RekenmachineApp extends StatelessWidget {
  const RekenmachineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const RekenmachinePagina(),
    );
  }
}

class RekenmachinePagina extends StatefulWidget {
  const RekenmachinePagina({super.key});

  @override
  State<RekenmachinePagina> createState() => _RekenmachinePaginaState();
}

class _RekenmachinePaginaState extends State<RekenmachinePagina> {
  final eersteController = TextEditingController();
  final tweedeController = TextEditingController();

  String resultaat = 'Nog geen berekening';

  void bereken(String bewerking) {
    final getal1 = double.tryParse(eersteController.text);
    final getal2 = double.tryParse(tweedeController.text);

    if (getal1 == null || getal2 == null) {
      setState(() {
        resultaat = 'Vul twee geldige getallen in.';
      });
      return;
    }

    double antwoord;

    if (bewerking == '+') {
      antwoord = getal1 + getal2;
    } else if (bewerking == '-') {
      antwoord = getal1 - getal2;
    } else if (bewerking == 'x') {
      antwoord = getal1 * getal2;
    } else {
      if (getal2 == 0) {
        setState(() {
          resultaat = 'Delen door 0 kan niet.';
        });
        return;
      }
      antwoord = getal1 / getal2;
    }

    setState(() {
      resultaat = 'Antwoord: $antwoord';
    });
  }

  void wisAlles() {
    eersteController.clear();
    tweedeController.clear();

    setState(() {
      resultaat = 'Nog geen berekening';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celal rekenmachine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: eersteController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Eerste getal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: tweedeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Tweede getal',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(
                  onPressed: () => bereken('+'),
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => bereken('-'),
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => bereken('x'),
                  child: const Text('x'),
                ),
                ElevatedButton(
                  onPressed: () => bereken('/'),
                  child: const Text('/'),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Text(
              resultaat,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: wisAlles,
              child: const Text('Opnieuw'),
            ),
          ],
        ),
      ),
    );
  }
}
