import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PACalculationScreen extends StatefulWidget {
  const PACalculationScreen({super.key});

  @override
  _PACalculationScreenState createState() => _PACalculationScreenState();
}

class _PACalculationScreenState extends State<PACalculationScreen> {
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
      double positionMinusOneResultTimesReason = positionMinusOneResult * reason;

      double resultPAgeneralTerm = firstTerm + (position - 1) * reason;

      setState(() {
        result = 'an = a1 + (n - 1) * r\n'
            'a$position = $firstTerm + ($position - 1) * $reason\n'
            'a$position = $firstTerm + $positionMinusOneResult * $reason\n'
            'a$position = $firstTerm + $positionMinusOneResultTimesReason\n'
            'a$position = ${resultPAgeneralTerm.toStringAsFixed(2)}';

        explanation = 'Explicação:\n\n'
            '- A fórmula geral da Progressão Aritmética (PA) é: **an = a1 + (n - 1) * r**.\n'
            '- Isso significa que o termo geral (**an**) é obtido somando o primeiro termo (**a1**) com a razão (**r**) multiplicada pela posição anterior ao termo atual (**n - 1**).\n'
            '- Aqui, você forneceu:\n'
            '  • Primeiro termo (**a1**): $firstTerm\n'
            '  • Razão (**r**): $reason\n'
            '  • Posição (**n**): $position\n\n'
            'Substituímos os valores na fórmula e encontramos o termo geral da PA.';
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
        backgroundColor: context.colors.primary, //Cálculo de PA
        title: Text(
          'Progressão Aritmética (PA)',
          style: context.textStyles.textTitle.copyWith(
            color: Colors.white,
            fontSize: 25, // Define o tamanho da fonte
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
                'A PA é uma sequência numérica em que cada termo, a partir do segundo, é igual ao anterior somado a uma razão fixa (r). Insira os valores e calcule o termo geral da PA.',
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
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  labelText: 'Razão (r)',
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
                    return 'Informe razão "r" > 0';
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
                    return 'Informe posição > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _validateAndCalculate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
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
