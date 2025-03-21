import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  void incremented() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  bool get isEmpty => count == 0;
  bool get isFull => count == 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? 'Acesso Bloqueado' : 'Acesso Liberado',
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              count.toString(),
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isEmpty ? const Color(0xaaafae24) : const Color(0xffafae24),
                    fixedSize: const Size(110, 75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: isEmpty ? () {} : decrement,
                  child: const Text(
                    'Sair',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff031c5f),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isFull ? const Color(0xaaafae24) : const Color(0xffafae24),
                    fixedSize: const Size(110, 75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: isFull ? () {} : incremented,
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff031c5f),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}