#!/usr/bin/env python3
"""
API Backend pour intégrer Call Center AI, LocalAI et Handy
Sert de pont entre l'application Flutter et les services intégrés
"""

from flask import Flask, request, jsonify
from flask_cors import CORS
import os
import json
import subprocess
import logging
from typing import Dict, Any, Optional

app = Flask(__name__)
CORS(app)  # Permettre les requêtes depuis Flutter

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Configuration
CALL_CENTER_AI_PATH = os.path.join(os.path.dirname(__file__), '..', 'integrations', 'call-center-ai')
LOCALAI_URL = os.getenv('LOCALAI_URL', 'http://localhost:8080')
HANDY_API_URL = os.getenv('HANDY_API_URL', 'http://localhost:3000')

# ============================================
# CALL CENTER AI ENDPOINTS
# ============================================

@app.route('/api/call-center/call', methods=['POST'])
def initiate_call():
    """Initier un appel avec Call Center AI"""
    try:
        data = request.json
        
        # Valider les données requises
        required_fields = ['phone_number', 'task']
        for field in required_fields:
            if field not in data:
                return jsonify({'error': f'Champ requis manquant: {field}'}), 400
        
        # Préparer la commande pour appeler call-center-ai
        # Note: Cette implémentation dépend de la structure exacte de call-center-ai
        # Vous devrez adapter selon la documentation du projet
        
        logger.info(f"Initiation d'appel vers {data['phone_number']}")
        
        # Placeholder - à adapter selon call-center-ai
        response = {
            'call_id': f"call_{hash(data['phone_number'])}",
            'status': 'initiated',
            'phone_number': data['phone_number'],
            'message': 'Appel initié avec succès'
        }
        
        return jsonify(response), 201
        
    except Exception as e:
        logger.error(f"Erreur initiation appel: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/call-center/call/<call_id>/status', methods=['GET'])
def get_call_status(call_id: str):
    """Obtenir le statut d'un appel"""
    try:
        # Placeholder - à adapter selon call-center-ai
        response = {
            'call_id': call_id,
            'status': 'completed',
            'duration': 120,
            'timestamp': '2024-01-01T12:00:00Z'
        }
        
        return jsonify(response), 200
        
    except Exception as e:
        logger.error(f"Erreur récupération statut: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/call-center/call/<call_id>/data', methods=['GET'])
def get_call_data(call_id: str):
    """Obtenir les données collectées pendant un appel"""
    try:
        # Placeholder - à adapter selon call-center-ai
        response = {
            'call_id': call_id,
            'claim': {
                'booking_id': '12345',
                'issue_type': 'question',
            },
            'messages': [],
            'summary': 'Appel terminé avec succès'
        }
        
        return jsonify(response), 200
        
    except Exception as e:
        logger.error(f"Erreur récupération données: {e}")
        return jsonify({'error': str(e)}), 500

# ============================================
# LOCALAI ENDPOINTS (Proxy)
# ============================================

@app.route('/api/localai/chat', methods=['POST'])
def localai_chat():
    """Proxy pour LocalAI chat completions"""
    try:
        import requests
        
        data = request.json
        localai_url = f"{LOCALAI_URL}/v1/chat/completions"
        
        response = requests.post(
            localai_url,
            json=data,
            headers={'Content-Type': 'application/json'},
            timeout=30
        )
        
        return jsonify(response.json()), response.status_code
        
    except Exception as e:
        logger.error(f"Erreur LocalAI: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/localai/models', methods=['GET'])
def localai_models():
    """Lister les modèles LocalAI disponibles"""
    try:
        import requests
        
        localai_url = f"{LOCALAI_URL}/v1/models"
        
        response = requests.get(localai_url, timeout=10)
        
        return jsonify(response.json()), response.status_code
        
    except Exception as e:
        logger.error(f"Erreur liste modèles LocalAI: {e}")
        return jsonify({'error': str(e)}), 500

# ============================================
# HANDY ENDPOINTS (Proxy)
# ============================================

@app.route('/api/handy/transcribe', methods=['POST'])
def handy_transcribe():
    """Transcrire un fichier audio avec Handy"""
    try:
        import requests
        
        if 'audio' not in request.files:
            return jsonify({'error': 'Fichier audio requis'}), 400
        
        audio_file = request.files['audio']
        language = request.form.get('language')
        model = request.form.get('model', 'whisper-small')
        
        # Envoyer à Handy API
        files = {'audio': (audio_file.filename, audio_file.stream, audio_file.content_type)}
        data = {}
        if language:
            data['language'] = language
        if model:
            data['model'] = model
        
        handy_url = f"{HANDY_API_URL}/api/transcribe"
        
        response = requests.post(
            handy_url,
            files=files,
            data=data,
            timeout=60
        )
        
        return jsonify(response.json()), response.status_code
        
    except Exception as e:
        logger.error(f"Erreur transcription Handy: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/handy/models', methods=['GET'])
def handy_models():
    """Lister les modèles Handy disponibles"""
    try:
        import requests
        
        handy_url = f"{HANDY_API_URL}/api/models"
        
        response = requests.get(handy_url, timeout=10)
        
        return jsonify(response.json()), response.status_code
        
    except Exception as e:
        logger.error(f"Erreur liste modèles Handy: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/api/handy/health', methods=['GET'])
def handy_health():
    """Vérifier la santé du service Handy"""
    try:
        import requests
        
        handy_url = f"{HANDY_API_URL}/health"
        
        response = requests.get(handy_url, timeout=5)
        
        return jsonify({
            'status': 'healthy' if response.status_code == 200 else 'unhealthy',
            'status_code': response.status_code
        }), 200
        
    except Exception as e:
        logger.error(f"Erreur health check Handy: {e}")
        return jsonify({'status': 'unhealthy', 'error': str(e)}), 500

# ============================================
# HEALTH CHECK
# ============================================

@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'services': {
            'call_center_ai': 'available',
            'localai': LOCALAI_URL,
            'handy': HANDY_API_URL
        }
    }), 200

# ============================================
# MAIN
# ============================================

if __name__ == '__main__':
    port = int(os.getenv('PORT', 5000))
    debug = os.getenv('DEBUG', 'False').lower() == 'true'
    
    logger.info(f"Démarrage du serveur API sur le port {port}")
    logger.info(f"Call Center AI path: {CALL_CENTER_AI_PATH}")
    logger.info(f"LocalAI URL: {LOCALAI_URL}")
    logger.info(f"Handy API URL: {HANDY_API_URL}")
    
    app.run(host='0.0.0.0', port=port, debug=debug)

