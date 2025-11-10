#!/bin/bash
# Script de démarrage du backend API pour Linux/macOS
# Usage: ./start.sh

echo "🚀 Démarrage du backend API Campbnb"

# Vérifier si l'environnement virtuel existe
if [ ! -d "venv" ]; then
    echo "❌ L'environnement virtuel n'existe pas!"
    echo "   Exécutez d'abord ./setup.sh"
    exit 1
fi

# Activer l'environnement virtuel
echo ""
echo "📦 Activation de l'environnement virtuel..."
source venv/bin/activate

# Vérifier les dépendances
echo "📦 Vérification des dépendances..."
if ! pip show flask &> /dev/null; then
    echo "❌ Flask n'est pas installé!"
    echo "   Installation des dépendances..."
    pip install -r requirements.txt
fi

# Démarrer le serveur
echo ""
echo "🚀 Démarrage du serveur sur http://localhost:5000"
echo "   Appuyez sur Ctrl+C pour arrêter"
echo ""

python api_server.py

