import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PercentageCalculationScreen extends StatefulWidget {
  const PercentageCalculationScreen({super.key});

  @override
  _PercentageCalculationScreenState createState() => _PercentageCalculationScreenState();
}

class _PercentageCalculationScreenState extends State<PercentageCalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _percentageController = TextEditingController();
  String result = '';
  String explanation = '';

  void _validateAndCalculate() {
    if (_formKey.currentState!.validate()) {
      double value = double.parse(_valueController.text);
      double percentage = double.parse(_percentageController.text);

      double calculatedPercentage = (value * percentage) / 100;
      double divisor = 100;
      double calculateNumeratorResult = percentage * value;

      setState(() {
        result = 'Resultado: \n${percentage.toStringAsFixed(2)}% de ${value.toStringAsFixed(2)} = ${calculatedPercentage.toStringAsFixed(2)}\n'
            'Cálculo:\n'
            '(${percentage.toStringAsFixed(2)} * ${value.toStringAsFixed(2)}) / $divisor =\n'
            '${calculateNumeratorResult.toStringAsFixed(2)} / $divisor = ${calculatedPercentage.toStringAsFixed(2)}';

        explanation = 'Explicação:\n\n'
            '- A fórmula para calcular a porcentagem é: **(porcentagem x valor) / 100**.\n'
            '- Isso significa que **$percentage**% do valor **$value** é obtido ao multiplicar o valor da porcentagem (**$percentage**) pelo valor (**$value**) e dividir o produto por 100.\n'
            '- Aqui, você forneceu o valor **$value** e a porcentagem **$percentage**.\n\n'
            'Substituímos os valores no cálculo para determinar a porcentagem, como mostrado acima.';
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
          'Porcentagem',
          style: context.textStyles.textTitle.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        color: context.colors.background,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Descrição inicial
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Porcentagem é a razão entre um número e 100, representada pelo símbolo %. '
                    'Ela é amplamente usada para indicar proporções e partes de um todo. '
                    'Exemplo: 50% equivale a 50/100 ou 0,50.\n\nInsira os valores para o cálculo da porcentagem.',
                    style: context.textStyles.textRegular.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20),

                // Campo: Valor
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um valor.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo: Porcentagem
                TextFormField(
                  controller: _percentageController,
                  decoration: InputDecoration(
                    labelText: 'Porcentagem',
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o valor da porcentagem.';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor, insira um número válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Botão de Calcular
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
                      'Calcular Porcentagem',
                      style: context.textStyles.textButtonlabel.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Resultado
                if (result.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      result,
                      style: context.textStyles.textRegular.copyWith(fontSize: 16, color: Colors.black87),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                const SizedBox(height: 20),
                if (result.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

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
      ),
    );
  }
}
