import 'package:flutter/material.dart';

class EmployeeRegisterPage extends StatefulWidget {

  const EmployeeRegisterPage({ super.key });

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Cadastrar colaborador'),),
           body: const SingleChildScrollView(
            child: Column(
              children: [
                
              ],
            ),
           ),
       );
  }
}