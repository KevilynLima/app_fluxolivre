import 'package:app_fluxolivrep/src/widget/input_login_widget.dart';
import 'package:flutter/material.dart';

class AtvNivaldo extends StatelessWidget {
  const AtvNivaldo({super.key});


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center, 
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_fundologin.png'),
            fit: BoxFit.cover,
            )
          ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(image: AssetImage('assets/images/et.png')),
          ),
          const SizedBox(height: 30,),
          InputLoginWidget(
            icon: Icons.person_outline, 
            hint: 'Usuário', 
            obscure: false,
            controller: TextEditingController()),
          InputLoginWidget(
            icon: Icons.lock_outlined, 
            hint: 'Senha', 
            obscure: true,
            controller: TextEditingController()
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFAFAE24),
              minimumSize: Size(double.infinity,60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14)
              )
            ),
            onPressed: (){
              Navigator.of(context).pushNamed('/home');
            }, 
            child: const Text('acessar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Color(0xff031c5f)),))
                ],
          
                ),
        ),
      ),
    );
  }}