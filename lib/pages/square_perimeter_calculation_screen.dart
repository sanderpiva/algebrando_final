import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';

class SquarePerimeterCalculationScreen extends StatefulWidget {
  const SquarePerimeterCalculationScreen({Key? key}) : super(key: key);

  @override
  State<SquarePerimeterCalculationScreen> createState() => _SquarePerimeterCalculationScreenState();
}

class _SquarePerimeterCalculationScreenState extends State<SquarePerimeterCalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sideController = TextEditingController();
  String result = '';
  String explanation = '';

  void _calculatePerimeter() {
    if (_formKey.currentState!.validate()) {
      double side = double.parse(_sideController.text);
      double perimeter = 4 * side;

      setState(() {
        result = '''P = 4 x Lado\n
Perímetro = 4 x $side = ${perimeter.toStringAsFixed(2)}''';

        explanation = '''Explicação:

- A fórmula para calcular o perímetro de um quadrado é **P = 4 x Lado**.
- Isso significa que o perímetro (P) é igual a quatro vezes o comprimento do lado (L).
- Aqui, você forneceu:
  • Lado (L): $side
Substituímos os valores na fórmula e encontramos o perímetro do quadrado.''';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.primary,
        title: Text(
          'Perímetro do Quadrado',
          style: context.textStyles.textTitle.copyWith(color: Colors.white),
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
                'Para calcular o perímetro de um quadrado, usamos a fórmula: P = 4 x L, onde L é o comprimento do lado do quadrado. Pratique:',
                style: context.textStyles.textRegular.copyWith(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _sideController,
                decoration: InputDecoration(
                  labelText: 'Lado do Quadrado',
                  labelStyle: context.textStyles.textRegular,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o valor do lado';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Digite um número válido';
                  }
                  if (double.tryParse(value) != null && double.tryParse(value)! == 0){
                    return 'Informe valor > 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _calculatePerimeter,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    backgroundColor: context.colors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Calcular Perímetro',
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
