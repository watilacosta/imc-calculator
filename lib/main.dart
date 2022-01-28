import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = 'Informe seus dados';
  double _imc = 0;

  void _resetFields() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _imc = 0;
      _infoText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaIMC() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;

    setState(() {
      _imc = peso / (altura * altura);
      _infoText = 'IMC =  ${_imc.toStringAsPrecision(3)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Calculadora de IMC'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.green,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: pesoController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Insira seu peso!';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (Kg)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                ),
              ),
              TextFormField(
                controller: alturaController,
                validator: (value) {
                  if(value!.isEmpty) {
                    return 'Insira sua altura!';
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (cm)',
                  labelStyle: TextStyle(color: Colors.green),
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()) {
                    _calculaIMC();
                  }
                },
                child: const Text('Calcular'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  primary: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
