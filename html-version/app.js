// Données mockées pour les listings
const mockListings = [
    {
        id: '1',
        title: 'Camping au bord du lac',
        location: 'Lac-Saint-Jean, QC',
        type: 'Tente',
        price: 45,
        image: '🏕️',
        description: 'Magnifique emplacement de camping au bord du lac avec vue imprenable. Parfait pour les amoureux de la nature.',
        amenities: ['Feu de camp', 'Toilettes', 'Douches', 'Eau potable', 'Wi-Fi'],
        rating: 4.8,
        reviews: 24,
        isPopular: true
    },
    {
        id: '2',
        title: 'Chalet rustique en forêt',
        location: 'Charlevoix, QC',
        type: 'Chalet',
        price: 120,
        image: '🏠',
        description: 'Chalet confortable au cœur de la forêt québécoise. Idéal pour une escapade en famille ou entre amis.',
        amenities: ['Cuisine équipée', 'Chauffage', 'Lits', 'Terrasse', 'Parking'],
        rating: 4.9,
        reviews: 18,
        isPopular: true
    },
    {
        id: '3',
        title: 'Emplacement pour VR',
        location: 'Gaspésie, QC',
        type: 'VR',
        price: 35,
        image: '🚐',
        description: 'Emplacement spacieux pour véhicule récréatif avec toutes les commodités nécessaires.',
        amenities: ['Branchement électrique', 'Eau', 'Égout', 'Wi-Fi', 'Laverie'],
        rating: 4.6,
        reviews: 31,
        isPopular: false
    },
    {
        id: '4',
        title: 'Glamping sous les étoiles',
        location: 'Laurentides, QC',
        type: 'Glamping',
        price: 150,
        image: '✨',
        description: 'Expérience de glamping unique avec tente de luxe et vue sur les étoiles. Inoubliable !',
        amenities: ['Lit confortable', 'Chauffage', 'Salle de bain privée', 'Petit-déjeuner', 'Wi-Fi'],
        rating: 5.0,
        reviews: 12,
        isPopular: true
    },
    {
        id: '5',
        title: 'Camping sauvage',
        location: 'Abitibi, QC',
        type: 'Tente',
        price: 25,
        image: '🌲',
        description: 'Pour les vrais amateurs de camping sauvage. Aucune commodité, juste la nature pure.',
        amenities: ['Feu de camp autorisé', 'Eau à proximité'],
        rating: 4.5,
        reviews: 8,
        isPopular: false
    },
    {
        id: '6',
        title: 'Van aménagé',
        location: 'Cantons-de-l\'Est, QC',
        type: 'Van',
        price: 80,
        image: '🚍',
        description: 'Van entièrement aménagé pour une expérience de camping mobile confortable.',
        amenities: ['Kitchenette', 'Lit', 'Chauffage', 'Électricité', 'Eau'],
        rating: 4.7,
        reviews: 15,
        isPopular: false
    }
];

// État de l'application
const appState = {
    currentView: 'home',
    currentListing: null,
    favorites: JSON.parse(localStorage.getItem('favorites') || '[]'),
    theme: localStorage.getItem('theme') || 'light',
    searchQuery: ''
};

// Initialisation
document.addEventListener('DOMContentLoaded', () => {
    initTheme();
    renderListings();
    setupEventListeners();
});

// Gestion du thème
function initTheme() {
    document.documentElement.setAttribute('data-theme', appState.theme);
    const themeToggle = document.getElementById('themeToggle');
    if (themeToggle) {
        themeToggle.querySelector('.icon').textContent = appState.theme === 'dark' ? '☀️' : '🌙';
    }
}

function toggleTheme() {
    appState.theme = appState.theme === 'light' ? 'dark' : 'light';
    localStorage.setItem('theme', appState.theme);
    document.documentElement.setAttribute('data-theme', appState.theme);
    const themeToggle = document.getElementById('themeToggle');
    if (themeToggle) {
        themeToggle.querySelector('.icon').textContent = appState.theme === 'dark' ? '☀️' : '🌙';
    }
}

// Rendu des listings
function renderListings(listings = mockListings) {
    const grid = document.getElementById('listingsGrid');
    if (!grid) return;

    grid.innerHTML = listings.map(listing => `
        <div class="listing-card" data-id="${listing.id}">
            <div class="listing-image" style="position: relative;">
                ${listing.isPopular ? '<div class="listing-badge">Populaire</div>' : ''}
                <span style="font-size: 64px;">${listing.image}</span>
            </div>
            <div class="listing-content">
                <div class="listing-header">
                    <div>
                        <div class="listing-title">${listing.title}</div>
                        <div class="listing-location">${listing.location}</div>
                        <div class="listing-type">${listing.type}</div>
                    </div>
                    <div class="listing-price">
                        <span class="price-amount">$${listing.price}</span>
                        <span class="price-unit"> / nuit</span>
                    </div>
                </div>
            </div>
        </div>
    `).join('');

    // Ajouter les event listeners
    document.querySelectorAll('.listing-card').forEach(card => {
        card.addEventListener('click', () => {
            const id = card.dataset.id;
            showListingDetail(id);
        });
    });
}

// Afficher les détails d'un listing
function showListingDetail(id) {
    const listing = mockListings.find(l => l.id === id);
    if (!listing) return;

    appState.currentListing = listing;
    appState.currentView = 'detail';

    const detailView = document.getElementById('detailView');
    const homeView = document.getElementById('homeView');
    const listingDetail = document.getElementById('listingDetail');

    if (detailView && homeView && listingDetail) {
        homeView.classList.remove('active');
        detailView.classList.add('active');
        
        listingDetail.innerHTML = `
            <div class="detail-image">
                <span style="font-size: 96px;">${listing.image}</span>
            </div>
            <div class="detail-content">
                <div class="detail-header">
                    <h1 class="detail-title">${listing.title}</h1>
                    <div class="detail-location">📍 ${listing.location}</div>
                    <div class="detail-price">$${listing.price} / nuit</div>
                    <div style="display: flex; align-items: center; gap: 8px; margin-top: 8px;">
                        <span>⭐ ${listing.rating}</span>
                        <span style="color: var(--text-secondary);">(${listing.reviews} avis)</span>
                    </div>
                </div>
                
                <div class="detail-section">
                    <h2 class="section-title">Description</h2>
                    <p class="detail-description">${listing.description}</p>
                </div>
                
                <div class="detail-section">
                    <h2 class="section-title">Équipements</h2>
                    <ul class="amenities-list">
                        ${listing.amenities.map(amenity => `
                            <li class="amenity-item">
                                <span>✓</span>
                                <span>${amenity}</span>
                            </li>
                        `).join('')}
                    </ul>
                </div>
                
                <button class="btn-primary" onclick="handleReservation('${listing.id}')">
                    Réserver maintenant
                </button>
            </div>
        `;
    }

    // Mettre à jour la navigation
    updateNavigation();
}

// Retour à la liste
function goBack() {
    appState.currentView = 'home';
    const detailView = document.getElementById('detailView');
    const homeView = document.getElementById('homeView');

    if (detailView && homeView) {
        detailView.classList.remove('active');
        homeView.classList.add('active');
    }

    updateNavigation();
}

// Gestion de la recherche
function handleSearch() {
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                performSearch(searchInput.value);
            }
        });
    }

    const searchBox = document.getElementById('searchBox');
    if (searchBox) {
        searchBox.addEventListener('click', () => {
            performSearch('');
        });
    }
}

function performSearch(query) {
    appState.searchQuery = query.toLowerCase();
    
    if (!query.trim()) {
        renderListings();
        return;
    }

    const filtered = mockListings.filter(listing => 
        listing.title.toLowerCase().includes(appState.searchQuery) ||
        listing.location.toLowerCase().includes(appState.searchQuery) ||
        listing.type.toLowerCase().includes(appState.searchQuery) ||
        listing.description.toLowerCase().includes(appState.searchQuery)
    );

    renderListings(filtered);
}

// Gestion des filtres
function setupFilters() {
    document.querySelectorAll('.filter-chip').forEach(chip => {
        chip.addEventListener('click', () => {
            document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
            chip.classList.add('active');
            
            const filter = chip.dataset.filter;
            applyFilter(filter);
        });
    });
}

function applyFilter(filterType) {
    let filtered = [...mockListings];
    
    switch(filterType) {
        case 'price':
            filtered.sort((a, b) => a.price - b.price);
            break;
        case 'type':
            // Garder l'ordre par défaut
            break;
        case 'region':
            filtered.sort((a, b) => a.location.localeCompare(b.location));
            break;
    }
    
    renderListings(filtered);
}

// Navigation du bas
function setupBottomNav() {
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', () => {
            const view = item.dataset.view;
            switchView(view);
            
            // Mettre à jour l'état actif
            document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
            item.classList.add('active');
        });
    });
}

function switchView(view) {
    appState.currentView = view;
    
    // Masquer toutes les vues
    document.querySelectorAll('.view').forEach(v => v.classList.remove('active'));
    
    // Afficher la vue appropriée
    switch(view) {
        case 'home':
            document.getElementById('homeView')?.classList.add('active');
            break;
        case 'favorites':
            showFavorites();
            break;
        case 'bookings':
            showBookings();
            break;
        case 'profile':
            showProfile();
            break;
    }
}

function showFavorites() {
    const homeView = document.getElementById('homeView');
    if (homeView) {
        homeView.classList.add('active');
        const favorites = mockListings.filter(l => appState.favorites.includes(l.id));
        renderListings(favorites.length > 0 ? favorites : []);
    }
}

function showBookings() {
    const homeView = document.getElementById('homeView');
    if (homeView) {
        homeView.classList.add('active');
        homeView.innerHTML = `
            <div style="text-align: center; padding: 48px 24px;">
                <div style="font-size: 64px; margin-bottom: 16px;">📅</div>
                <h2 style="margin-bottom: 8px;">Aucune réservation</h2>
                <p style="color: var(--text-secondary);">Vous n'avez pas encore de réservations.</p>
            </div>
        `;
    }
}

function showProfile() {
    const homeView = document.getElementById('homeView');
    if (homeView) {
        homeView.classList.add('active');
        homeView.innerHTML = `
            <div style="max-width: 600px; margin: 0 auto; padding: 24px;">
                <div style="text-align: center; margin-bottom: 32px;">
                    <div style="width: 100px; height: 100px; border-radius: 50%; background: var(--primary); margin: 0 auto 16px; display: flex; align-items: center; justify-content: center; font-size: 48px;">
                        👤
                    </div>
                    <h2 style="margin-bottom: 8px;">Utilisateur Test</h2>
                    <p style="color: var(--text-secondary);">utilisateur@test.com</p>
                </div>
                
                <div style="background: var(--surface-light); border-radius: var(--radius-md); padding: 24px; margin-bottom: 16px;">
                    <h3 style="margin-bottom: 16px;">Paramètres</h3>
                    <button class="btn-primary" style="margin-top: 0; margin-bottom: 12px;">Modifier le profil</button>
                    <button class="btn-primary" style="margin-top: 0; margin-bottom: 12px; background: var(--secondary);">Préférences</button>
                    <button class="btn-primary" style="margin-top: 0; background: var(--text-secondary);">Déconnexion</button>
                </div>
            </div>
        `;
    }
}

function updateNavigation() {
    // Réinitialiser la navigation du bas si nécessaire
    document.querySelectorAll('.nav-item').forEach(item => {
        if (appState.currentView === 'home' && item.dataset.view === 'home') {
            item.classList.add('active');
        } else {
            item.classList.remove('active');
        }
    });
}

// Gestion des réservations
function handleReservation(listingId) {
    const listing = mockListings.find(l => l.id === listingId);
    if (!listing) return;

    alert(`Réservation pour "${listing.title}"\n\nPrix: $${listing.price} / nuit\n\nCette fonctionnalité sera disponible dans la version complète de l'application.`);
}

// Configuration des event listeners
function setupEventListeners() {
    // Toggle thème
    const themeToggle = document.getElementById('themeToggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', toggleTheme);
    }

    // Bouton retour
    const backButton = document.getElementById('backButton');
    if (backButton) {
        backButton.addEventListener('click', goBack);
    }

    // Recherche
    handleSearch();

    // Filtres
    setupFilters();

    // Navigation du bas
    setupBottomNav();
}

// Exposer les fonctions globales si nécessaire
window.handleReservation = handleReservation;

