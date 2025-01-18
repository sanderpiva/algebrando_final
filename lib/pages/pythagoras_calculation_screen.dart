import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:app_mt_reserva/core/ui/extensions/colors_extension.dart';
import 'package:app_mt_reserva/core/ui/extensions/text_style_extension.dart';

class PythagorasCalculationScreen extends StatefulWidget {
  const PythagorasCalculationScreen({Key? key}) : super(key: key);

  @override
  State<PythagorasCalculationScreen> createState() => _PythagorasCalculationScreenState();
}

class _PythagorasCalculationScreenState extends State<PythagorasCalculationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oppositeSideController = TextEditingController();
  final _adjacentSideController = TextEditingController();
  String result = '';
  String explanation = '';

  void _calculateHypotenuse() {
    if (_formKey.currentState!.validate()) {
      double oppositeSide = double.parse(_oppositeSideController.text);
      double adjacentSide = double.parse(_adjacentSideController.text);
      double hypotenuse = sqrt(oppositeSide * oppositeSide + adjacentSide * adjacentSide);
      double oppositeSideSquare = oppositeSide * oppositeSide;
      double adjacentSideSquare = adjacentSide * adjacentSide;

      setState(() {
        result = '''
Hipotenusa = √(${(oppositeSide * oppositeSide + adjacentSide * adjacentSide).toStringAsFixed(2)}) = ${hypotenuse.toStringAsFixed(2)}
Hipotenusa² = (cateto oposto)² + (cateto adjacente)²
Hipotenusa² = (${oppositeSide.toStringAsFixed(2)} * ${oppositeSide.toStringAsFixed(2)}) + (${adjacentSide.toStringAsFixed(2)} * ${adjacentSide.toStringAsFixed(2)})
Hipotenusa² = ${oppositeSideSquare} + ${adjacentSideSquare}
Hipotenusa² = ${(oppositeSide * oppositeSide + adjacentSide * adjacentSide).toStringAsFixed(2)}
Hipotenusa = √(${(oppositeSide * oppositeSide + adjacentSide * adjacentSide).toStringAsFixed(2)}) = ${hypotenuse.toStringAsFixed(2)}
''';

        explanation = '''
O Teorema de Pitágoras descreve a relação entre os lados de um triângulo retângulo. A hipotenusa é o lado mais longo, oposto ao ângulo reto, e os catetos são os outros dois lados.

Fórmula: 
Hipotenusa² = Cateto Oposto² + Cateto Adjacente²

Com os valores inseridos, o cálculo foi realizado, e a hipotenusa é aproximadamente ${hypotenuse.toStringAsFixed(2)}.
''';
      });
    }
  }

  @override
  void dispose() {
    _oppositeSideController.dispose();
    _adjacentSideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Teorema de Pitágoras',
          style: context.textStyles.textTitle.copyWith(color: Colors.white),
        ),
        backgroundColor: context.colors.primary, // Laranja como a cor principal
        elevation: 0,
      ),
      body: Container(
        //color: context.colors.primary, // Fundo laranja
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text(
                'De acordo com o Teorema de Pitágoras, o quadrado da hipotenusa é igual à soma dos quadrados dos catetos. Preencha os campos abaixo para calcular a hipotenusa:',
                textAlign: TextAlign.justify,
                style: context.textStyles.textRegular.copyWith(color: Colors.black, fontSize: 16),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  color: Colors.white, // Fundo branco para contraste
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16, top: 16),
                          child: TextFormField(
                            controller: _oppositeSideController,
                            decoration: InputDecoration(
                              labelText: 'Cateto oposto',
                              labelStyle: context.textStyles.textRegular,
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Por favor insira um valor';
                              if (double.tryParse(value) == null) return 'Valor inválido';
                              if (double.tryParse(value) != null && double.tryParse(value)! == 0) return 'Informe valor > 0';
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            controller: _adjacentSideController,
                            decoration: InputDecoration(
                              labelText: 'Cateto adjacente',
                              labelStyle: context.textStyles.textRegular,
                              border: const OutlineInputBorder(),
                              contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Por favor insira um valor';
                              if (double.tryParse(value) == null) return 'Valor inválido';
                              if (double.tryParse(value) != null && double.tryParse(value)! == 0) return 'Informe valor > 0';
                              return null;
                            },
                          ),
                        ),
                        // Action Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: GestureDetector(
                            onTap: _calculateHypotenuse,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: context.colors.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Calcular Hipotenusa',
                                  style: context.textStyles.textButtonlabel.copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Results Section
                        if (result.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  result,
                                  style: context.textStyles.textRegular.copyWith(fontSize: 16, color: Colors.black87),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  explanation,
                                  style: context.textStyles.textRegular.copyWith(fontSize: 14, color: Colors.black54),
                                ),
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
