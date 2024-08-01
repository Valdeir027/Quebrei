import 'package:flutter/material.dart';
import 'package:myapp/components/HeaderText.dart';
import '../models/Conta.dart';
import '../database_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _saldoController = TextEditingController();
  late DatabaseHelper _dbHelper;
  List<Conta> _contas = [];

  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper();
    _loadContas();
  }

  void _saveConta() async {
    double saldo = double.parse(_saldoController.text);
    Conta conta = Conta(saldo: saldo);
    await _dbHelper.insertConta(conta);
    _loadContas();
  }

  void _loadContas() async {
    List<Conta> contas = await _dbHelper.getContas();
    setState(() {
      _contas = contas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: HeaderText(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _saldoController,
              decoration: InputDecoration(labelText: 'Enter balance'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveConta,
              child: Text('Save Account'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _contas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Saldo: ${_contas[index].saldo}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
