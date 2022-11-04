import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pokemon_box_calc/src/utils.dart';

import 'src/pokemon_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PokemonManager().loadPokemonList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blueGrey),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String grid = '';
  String pokemon = '';
  String boxPos = '';

  TextEditingController controller = TextEditingController();
  int random = Random.secure().nextInt(PokemonManager().pokemons.length);

  TextEditingController gridController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      controller.text = random.toString();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 50),
            ),
            const Text('Taper l`id du pokemon'),
            Center(
                child: Container(
                    padding:
                        const EdgeInsets.only(left: 50, right: 50, bottom: 10),
                    child: TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onEditingComplete: _checkInput))),
            ElevatedButton(
                onPressed: _checkInput, child: const Text("Calculer !")),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(pokemon)),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(boxPos)),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Text(grid))
          ],
        ),
      ),
    );
  }

  Future<void> _checkInput() async {
    if (controller.text.isEmpty) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Le numéro ne peux pas être vide !'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
      return;
    }

    if (int.tryParse(controller.text) == null) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('${controller.text} n`\'est un numéro valide'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
      return;
    }

    int index = int.parse(controller.text);

    if (index <= 0 || index > PokemonManager().pokemons.length) {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('$index n`\'est un index valide !'),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
      return;
    }

    setState(() {
      pokemon = getPokemonName(index);
      boxPos = "Box ${getBox(index)} @ Emplacement ${getPosition(index)}";
      grid = getGrid(index);
    });
  }
}
