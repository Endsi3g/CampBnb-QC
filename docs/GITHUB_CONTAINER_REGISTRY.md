# Guide GitHub Container Registry

Ce guide explique comment utiliser GitHub Container Registry pour publier et utiliser les images Docker du projet CampBnb.

## 📦 À propos du Container Registry

GitHub Container Registry (ghcr.io) permet de stocker et gérer des images Docker et OCI dans votre organisation ou compte personnel GitHub. Les images sont automatiquement liées au repository et héritent des permissions.

## 🔐 Authentification

### Avec un Personal Access Token (classic)

1. **Créer un token** sur [GitHub Settings > Developer settings > Personal access tokens](https://github.com/settings/tokens/new)

2. **Sélectionner les scopes nécessaires** :
   - `read:packages` - Pour télécharger les images
   - `write:packages` - Pour publier les images
   - `delete:packages` - Pour supprimer les images

3. **Sauvegarder le token** comme variable d'environnement :

```bash
# Windows PowerShell
$env:CR_PAT="YOUR_TOKEN"

# Linux/macOS
export CR_PAT=YOUR_TOKEN
```

4. **S'authentifier** :

```bash
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

> **Note** : Remplacez `USERNAME` par votre nom d'utilisateur GitHub.

### Avec GitHub Actions

Le workflow utilise automatiquement `GITHUB_TOKEN` qui a les permissions nécessaires pour publier dans le repository.

## 🚀 Publication automatique

### Workflow GitHub Actions

Le workflow `.github/workflows/docker-publish.yml` publie automatiquement l'image Docker lors de :

- Push sur la branche `main` ou `develop`
- Modification des fichiers dans `backend/`
- Déclenchement manuel via `workflow_dispatch`

### Tags automatiques

L'image est taguée avec :
- `latest` - Pour la branche par défaut
- `main` ou `develop` - Selon la branche
- `sha-<commit-sha>` - SHA du commit
- Version semver si disponible

## 📥 Utilisation de l'image

### Pull de l'image

```bash
# Image latest
docker pull ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest

# Image d'une branche spécifique
docker pull ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:main

# Image par digest (recommandé pour la production)
docker pull ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend@sha256:82jf9a84u29hiasldj289498uhois8498hjs29hkuhs
```

### Exécution locale

```bash
docker run -d \
  --name campbnb-backend \
  -p 5000:5000 \
  -e LOCALAI_URL=http://host.docker.internal:8080 \
  -e HANDY_API_URL=http://host.docker.internal:3000 \
  ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest
```

### Exécution avec docker-compose

```yaml
version: '3.8'

services:
  backend:
    image: ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest
    ports:
      - "5000:5000"
    environment:
      - LOCALAI_URL=http://localai:8080
      - HANDY_API_URL=http://handy:3000
      - PORT=5000
      - DEBUG=false
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:5000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
```

## 🏗️ Construction manuelle

### Build local

```bash
# Depuis la racine du projet
docker build -t campbnb-backend -f backend/Dockerfile ./backend
```

### Tag et push manuel

```bash
# Taguer l'image
docker tag campbnb-backend ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:1.0.0

# Push vers GitHub Container Registry
docker push ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:1.0.0
```

## 🔍 Inspection de l'image

### Voir les métadonnées

```bash
docker inspect ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest
```

### Trouver le digest SHA

```bash
docker inspect ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest | grep Digest
```

Ou directement :

```bash
docker pull ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest
# Le digest s'affiche dans la sortie
```

## 📋 Métadonnées de l'image

L'image Docker contient les métadonnées suivantes (définies dans le Dockerfile) :

- `org.opencontainers.image.source` - URL du repository GitHub
- `org.opencontainers.image.description` - Description de l'image
- `org.opencontainers.image.licenses` - Licence (PROPRIETARY)

Ces métadonnées apparaissent sur la page du package GitHub.

## 🔒 Permissions et visibilité

### Visibilité par défaut

- Les packages sont **privés** par défaut lors de la première publication
- Pour rendre un package public, allez dans les paramètres du package sur GitHub

### Héritage des permissions

Si le package est lié à un repository :
- Il hérite automatiquement des permissions du repository
- Les workflows GitHub Actions du repository ont automatiquement accès au package

### Configuration des permissions

1. Aller sur la page du package : `https://github.com/YOUR_USERNAME?tab=packages`
2. Cliquer sur le package `campbnb-backend`
3. Aller dans "Package settings" > "Manage access"
4. Configurer les permissions selon vos besoins

## 🐛 Dépannage

### Limites du Container Registry

- **Taille maximale par layer** : 10 GB
- **Timeout d'upload** : 10 minutes

### Problèmes courants

#### Erreur d'authentification

```bash
# Vérifier que le token est correct
echo $CR_PAT

# Ré-authentifier
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
```

#### Image non trouvée

- Vérifier que l'image a été publiée avec succès dans les Actions GitHub
- Vérifier les permissions du package
- Vérifier le nom exact de l'image (namespace/package:tag)

#### Pull lent

- Utiliser le digest SHA au lieu du tag pour éviter les vérifications
- Vérifier votre connexion internet
- Utiliser un registry mirror si disponible

## 📚 Ressources

- [Documentation officielle GitHub Container Registry](https://docs.github.com/fr/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
- [GitHub Packages Documentation](https://docs.github.com/fr/packages)
- [Docker Documentation](https://docs.docker.com/)

## 🔄 Mise à jour

Pour mettre à jour l'image :

1. Modifier le code dans `backend/`
2. Commit et push vers `main` ou `develop`
3. Le workflow GitHub Actions construit et publie automatiquement la nouvelle image
4. Pull la nouvelle image :

```bash
docker pull ghcr.io/YOUR_USERNAME/campbnb/campbnb-backend:latest
```

## ✅ Checklist de déploiement

- [ ] Token GitHub créé avec les scopes appropriés
- [ ] Authentification Docker réussie
- [ ] Workflow GitHub Actions configuré et testé
- [ ] Image publiée avec succès
- [ ] Permissions du package configurées
- [ ] Image testée localement
- [ ] Documentation à jour

