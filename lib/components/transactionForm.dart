import 'package:flutter/material.dart';


import 'adaptative_button.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {

  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  _submitForms(){
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if(title.isEmpty || value <= 0 || selectedDate == null){
      return;
    }

    widget.onSubmit(title, value, selectedDate);
  }



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom, // Tamanho do teclado(Na hora de preencher o form.)
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                label: 'Título',
                controller: titleController,
                //onSubmitted: (_) => _submitForms(),
              ),
              AdaptativeTextField(
                label: 'Valor (R\$)',
                controller: valueController,
                keyboradType: TextInputType.numberWithOptions(decimal: true),
                //onSubmitted: (_) => _submitForms(),
              ),
              AdaptativeDatePicker(
                selectedDate: selectedDate,
                onDateChanged: (newDate){
                  setState(() {
                    selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForms,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
