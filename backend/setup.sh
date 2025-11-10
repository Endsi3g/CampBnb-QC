#!/bin/bash
# Script d'installation du backend API pour Linux/macOS
# Usage: ./setup.sh

echo "🚀 Installation du backend API Campbnb"

# Vérifier si Python est installé
echo ""
echo "📦 Vérification de Python..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 n'est pas installé!"
    echo "   Installez Python 3 depuis https://www.python.org/downloads/"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
echo "✅ Python trouvé: $PYTHON_VERSION"

# Créer l'environnement virtuel
echo ""
echo "📦 Création de l'environnement virtuel..."
if [ -d "venv" ]; then
    echo "⚠️  L'environnement virtuel existe déjà"
    read -p "Voulez-vous le recréer? (o/N): " response
    if [[ "$response" =~ ^[Oo]$ ]]; then
        rm -rf venv
        python3 -m venv venv
        echo "✅ Environnement virtuel créé"
    fi
else
    python3 -m venv venv
    echo "✅ Environnement virtuel créé"
fi

# Activer l'environnement virtuel et installer les dépendances
echo ""
echo "📦 Installation des dépendances..."
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

if [ $? -eq 0 ]; then
    echo "✅ Dépendances installées avec succès"
else
    echo "❌ Erreur lors de l'installation des dépendances"
    exit 1
fi

echo ""
echo "✅ Installation terminée!"
echo ""
echo "Pour démarrer le serveur:"
echo "  source venv/bin/activate"
echo "  python api_server.py"

