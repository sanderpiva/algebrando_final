import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class PGCalculationScreen extends StatefulWidget {
  const PGCalculationScreen({Key? key}) : super(key: key);

  @override
  _PGCalculationScreenState createState() => _PGCalculationScreenState();
}

class _PGCalculationScreenState extends State<PGCalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstTermController = TextEditingController();
  final _reasonController = TextEditingController();
  final _positionController = TextEditingController();
  String result = '';
  String explanation = '';

  void _validateAndCalculate() {
    if (_formKey.currentState!.validate()) {
      double firstTerm = double.parse(_firstTermController.text);
      double reason = double.parse(_reasonController.text);
      int position = int.parse(_positionController.text);

      double positionMinusOneResult = (position - 1).toDouble();
      double positionElevatedPositionMinusOneResult = pow(reason, positionMinusOneResult).toDouble();

      double resultPGgeneralTerm = firstTerm * pow(reason, (position - 1).toDouble());

      setState(() {
        result = 'an = a1 * q ^ (n - 1)\n'
            'a$position = $firstTerm * ($reason) ^ ($position - 1)\n'
            'a$position = $firstTerm * ($reason) ^ ($positionMinusOneResult)\n'
            'a$position = $firstTerm * $positionElevatedPositionMinusOneResult\n'
            'a$position = ${resultPGgeneralTerm.toStringAsFixed(2)}';

        explanation = 'Explicação:\n\n'
            '- A fórmula geral da Progressão Geométrica (PG) é: **an = a1 * q^(n - 1)**.\n'
            '- Isso significa que o termo geral (**an**) é obtido ao multiplicar o primeiro termo (**a1**) pela razão (**q**) elevada a **n - 1**.\n'
            '- Aqui, você forneceu o primeiro termo como **$firstTerm**, a razão como **$reason**, e a posição como **$position**.\n\n'
            'Substituímos os valores na fórmula para encontrar o termo geral, como mostrado acima.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.primary,
        title: Text(
          'Progressão Geométrica (PG)',
          style: context.textStyles.textTitle.copyWith(
            color: Colors.white,
            fontSize: 23, // Define o tamanho da fonte
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 8),
              Text(
                'A PG é uma sequência numérica onde cada termo, a partir do segundo, é obtido ao multiplicar o termo anterior por uma razão fixa (q). Insira os valores e calcule o termo geral da PG.',
                style: context.textStyles.textRegular.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _firstTermController,
                decoration: InputDecoration(
                  labelText: 'Primeiro Termo (a1)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o primeiro termo';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Digite um número válido';
                  }
                  if (double.tryParse(value) != null && double.tryParse(value)! == 0){
                    return 'Informe primeiro termo da PG > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Razão (q)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a razão';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Digite um número válido';
                  }
                  if (double.tryParse(value) != null && double.tryParse(value)! == 0){
                    return 'Informe razão "q" > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(
                  labelText: 'Posição (n)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe a posição';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Digite um número inteiro válido';
                  }
                  if (double.tryParse(value) != null && double.tryParse(value)! == 0){
                    return 'Informe posicao > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndCalculate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: context.colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Calcular Termo Geral',
                    style: context.textStyles.textButtonlabel.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (result.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resultado:',
                      style: context.textStyles.textSemiBold.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      result,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      explanation,
                      style: context.textStyles.textRegular.copyWith(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
