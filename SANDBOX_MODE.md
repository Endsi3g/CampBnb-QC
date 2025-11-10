# Mode Sandbox - Campbnb

## 🚀 Qu'est-ce que le mode Sandbox?

Le mode Sandbox permet d'utiliser l'application **sans aucune connexion aux APIs externes**. Toutes les fonctionnalités fonctionnent avec des données mock (simulées) stockées localement.

## ✅ Avantages

- ✅ **Aucune configuration API nécessaire** - Fonctionne immédiatement
- ✅ **Pas de coûts** - Aucun appel API facturé
- ✅ **Développement rapide** - Testez toutes les fonctionnalités
- ✅ **Démo fonctionnelle** - Parfaite pour présenter l'application
- ✅ **Fonctionne hors ligne** - Pas besoin d'internet

## 🔧 Activation du mode Sandbox

### Option 1: Automatique (recommandé)

Le mode sandbox s'active **automatiquement** si:
- Le fichier `.env` n'existe pas
- Les clés API ne sont pas configurées dans `.env`

### Option 2: Manuel

Créez un fichier `.env` à la racine du projet avec:

```env
SANDBOX_MODE=true
```

### Option 3: Via le code

```dart
await EnvConfig.setSandboxMode(true);
```

## 📊 Données Mock Disponibles

### Campings (5 listings)
- Camping Domaine Aventura - Charlevoix (45$/nuit)
- Camping Éco-Lodge Laurentides (85$/nuit)
- Camping Rivière Rouge - Lanaudière (60$/nuit)
- Camping Mont-Tremblant - Expérience Premium (120$/nuit)
- Camping Île d'Orléans - Vue Panoramique (55$/nuit)

### Fonctionnalités Mock
- ✅ Authentification (inscription/connexion)
- ✅ Parcourir les campings
- ✅ Recherche et filtres
- ✅ Créer des réservations
- ✅ Gérer le profil
- ✅ Favoris
- ✅ Chatbot IA (réponses pré-programmées)
- ✅ Géolocalisation (position mock: Montréal)

## 🔄 Passer en mode Production

Pour utiliser les vraies APIs:

1. Créez un fichier `.env` avec vos clés API:
```env
SANDBOX_MODE=false
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
GOOGLE_MAPS_API_KEY=your-maps-key
GEMINI_API_KEY=your-gemini-key
```

2. Redémarrez l'application

## 📝 Notes

- Les données mock sont **stockées en mémoire** - elles disparaissent au redémarrage
- Les réservations et modifications sont **simulées** avec des délais réalistes
- Le chatbot IA retourne des **réponses pré-programmées** en mode sandbox
- La géolocalisation retourne une **position fixe** (Montréal) en mode sandbox

## 🐛 Dépannage

**L'application ne démarre pas en mode sandbox?**
- Vérifiez que `shared_preferences` est bien installé
- Vérifiez les logs pour voir le mode activé

**Comment savoir si je suis en mode sandbox?**
- Regardez les logs au démarrage: `🚀 Mode SANDBOX activé`
- Ou vérifiez: `EnvConfig.isSandboxMode`

