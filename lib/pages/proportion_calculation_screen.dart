import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';

class ProportionCalculationScreen extends StatefulWidget {
  const ProportionCalculationScreen({super.key});

  @override
  _ProportionCalculationScreenState createState() => _ProportionCalculationScreenState();
}

class _ProportionCalculationScreenState extends State<ProportionCalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _cController = TextEditingController();
  String result = '';
  String explanation = '';

  void _validateAndCalculate() {
    if (_formKey.currentState!.validate()) {
      double a = double.parse(_aController.text);
      double b = double.parse(_bController.text);
      double c = double.parse(_cController.text);

      if (a == 0 || b == 0 || c == 0) {
        setState(() {
          result = 'Não é possível dividir por zero. Valores > 0.';
          explanation = '';
        });
        return;
      }

      double d = (b * c) / a;
      double numeratorCalculationResult = c * b;

      setState(() {
        result = '''
                A - B
                   x
                C - D
\nD * A = C * B
D = (C * B) / A
D = (${c.toStringAsFixed(2)} * ${b.toStringAsFixed(2)}) / ${a.toStringAsFixed(2)}
D = ${numeratorCalculationResult.toStringAsFixed(2)} / ${a.toStringAsFixed(2)}
D = ${d.toStringAsFixed(2)}
''';

        explanation = '''
O cálculo foi realizado usando a fórmula da proporção:
D * A = C * B
Substituímos os valores fornecidos:\n
- Valor de A: $a
- Valor de B: $b
- Valor de C: $c

Após os cálculos, o resultado para D é ${d.toStringAsFixed(2)}.
A proporção foi confirmada como válida, já que a relação (B / A) é igual à relação (D / C).
''';
      });
    }
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proporção',
          style: context.textStyles.textTitle.copyWith(color: Colors.white),
        ),
        backgroundColor: context.colors.primary,
        elevation: 0,
      ),
      body: Container(
        //color: context.colors.primary,
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'A proporção ocorre quando o quociente de duas razões é igual. É possível resolver problemas envolvendo proporção com a fórmula: D * A = C * B. Preencha os campos abaixo para calcular:',
                textAlign: TextAlign.justify,
                style: context.textStyles.textRegular.copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Input Fields
                        TextFormField(
                          controller: _aController,
                          decoration: InputDecoration(
                            labelText: 'Valor de A',
                            labelStyle: context.textStyles.textRegular.copyWith(color: Colors.black54),
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Por favor, insira um valor para A';
                            if (double.tryParse(value) == null) return 'Digite um número válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _bController,
                          decoration: InputDecoration(
                            labelText: 'Valor de B',
                            labelStyle: context.textStyles.textRegular.copyWith(color: Colors.black54),
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Por favor, insira um valor para B';
                            if (double.tryParse(value) == null) return 'Digite um número válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _cController,
                          decoration: InputDecoration(
                            labelText: 'Valor de C',
                            labelStyle: context.textStyles.textRegular.copyWith(color: Colors.black54),
                            border: const OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Por favor, insira um valor para C';
                            if (double.tryParse(value) == null) return 'Digite um número válido';
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
                              'Calcular Proporção',
                              style: context.textStyles.textButtonlabel.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Result Section
                        if (result.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.amber[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  result,
                                  style: context.textStyles.textRegular.copyWith(fontSize: 16, color: Colors.black87),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                explanation,
                                style: context.textStyles.textRegular.copyWith(fontSize: 14, color: Colors.black54),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
