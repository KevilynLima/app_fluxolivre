import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Fluxo Livre - ADMIN',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            // Card de Usuários
            _buildMenuCard(
              context,
              'Usuários',
              Icons.people, 
              Colors.blueGrey.shade200,
              () {
                // Navegação para tela de Usuários (implementação futura)
                debugPrint('Navegando para Usuários');
              },
            ),
            
            // Card de Relatório
            _buildMenuCard(
              context,
              'Relatório',
              Icons.assignment,
              Colors.blueGrey.shade200,
              () {
                // Navegação para tela de Relatório (implementação futura)
                debugPrint('Navegando para Relatório');
              },
            ),
            
            // Card de Configurações
            _buildMenuCard(
              context,
              'Configurações',
              Icons.settings,
              Colors.black87,
              () {
                // Navegação para tela de Configurações (implementação futura)
                debugPrint('Navegando para Configurações');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color backgroundColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          color: backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 80.0,
                  color: Colors.white,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.black.withOpacity(0.3),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}