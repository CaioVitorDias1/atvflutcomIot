// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


import 'package:http/http.dart' as http;


import 'dart:async';
import 'dart:math';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Temperaturaiot()
    );
  }
}


class Temperaturaiot extends StatefulWidget {
  @override
  EstadoTemperatura createState() => EstadoTemperatura();
}

class EstadoTemperatura extends State<Temperaturaiot> {
  Timer? tempo;
  String placaesp32Url = "https://jsonplaceholder.typicode.com/comments?id=10"; 
  Random random = Random();

  @override
  void initState() {

    super.initState();
    
    tempo = Timer.periodic(Duration(seconds: 30), (tempo) {
      enviarTemp();
    });
  }

  @override
  void dispose() {


    tempo?.cancel();

    super.dispose();
  }

  Future<void> enviarTemp() async {

    int contador =0;
    double temperatura;

    if(contador ==3) {
    temperatura = 45 + random.nextDouble() * 15;
    contador = 0;
    /* os valorees aqui serão entre 45 e 60 */
    }else {
      temperatura = random.nextDouble() * 60;
      contador ++;
      /* os valorees aqui serão de 0 a 60 */
    }

     
    try {
      var response = await http.post(
        Uri.parse(placaesp32Url),
        body: {"temperatura": temperatura.toString()},
      );
      if (response.statusCode == 200) {
        print("Temperatura enviada: $temperatura");
      } else {
        print("erro ao enviar temperatura: ${response.statusCode}");
      }
    } catch (e) {
      print("deu erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperatura"),
      ),
      body: Center(
        child: Text(
          "Enviando dados para o ESP32",
          textAlign: TextAlign.center,


          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}