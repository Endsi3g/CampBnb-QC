-- ============================================
-- Campbnb - Schéma de Base de Données Supabase
-- ============================================

-- Extension pour UUID
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- TABLE: profiles
-- Profils utilisateurs étendus
-- ============================================
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  phone TEXT,
  bio TEXT,
  is_host BOOLEAN DEFAULT false,
  preferred_language TEXT DEFAULT 'fr',
  location TEXT, -- Ville, région
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  
  -- Gamification
  total_bookings INTEGER DEFAULT 0,
  total_listings INTEGER DEFAULT 0,
  badges JSONB DEFAULT '[]'::jsonb,
  points INTEGER DEFAULT 0
);

-- ============================================
-- TABLE: listings
-- Annonces de camping
-- ============================================
CREATE TABLE listings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  host_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  -- Informations de base
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  listing_type TEXT NOT NULL CHECK (listing_type IN ('tent', 'rv', 'cabin', 'van', 'glamping', 'other')),
  
  -- Localisation
  address TEXT NOT NULL,
  city TEXT NOT NULL,
  region TEXT NOT NULL, -- Région du Québec
  postal_code TEXT,
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL,
  
  -- Prix et disponibilité
  price_per_night DECIMAL(10, 2) NOT NULL,
  max_guests INTEGER NOT NULL DEFAULT 2,
  min_nights INTEGER DEFAULT 1,
  max_nights INTEGER,
  
  -- Équipements (JSON array)
  amenities JSONB DEFAULT '[]'::jsonb,
  
  -- Photos
  photos JSONB DEFAULT '[]'::jsonb, -- Array d'URLs
  
  -- Règles et informations
  house_rules TEXT,
  cancellation_policy TEXT DEFAULT 'moderate',
  
  -- Statut
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'pending', 'rejected')),
  is_featured BOOLEAN DEFAULT false,
  
  -- Métadonnées
  view_count INTEGER DEFAULT 0,
  rating_average DECIMAL(3, 2) DEFAULT 0,
  review_count INTEGER DEFAULT 0,
  
  -- Dates
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Index pour recherche
CREATE INDEX idx_listings_region ON listings(region);
CREATE INDEX idx_listings_city ON listings(city);
CREATE INDEX idx_listings_type ON listings(listing_type);
CREATE INDEX idx_listings_status ON listings(status);
CREATE INDEX idx_listings_location ON listings USING GIST (point(longitude, latitude));
CREATE INDEX idx_listings_host ON listings(host_id);

-- ============================================
-- TABLE: bookings
-- Réservations
-- ============================================
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  guest_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  -- Dates
  check_in DATE NOT NULL,
  check_out DATE NOT NULL,
  nights INTEGER NOT NULL,
  
  -- Détails
  guests INTEGER NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  deposit_amount DECIMAL(10, 2) DEFAULT 0,
  
  -- Statut
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled', 'completed', 'rejected')),
  
  -- Paiement (future)
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'refunded', 'failed')),
  payment_intent_id TEXT, -- Stripe
  
  -- Messages
  guest_message TEXT,
  host_response TEXT,
  
  -- Dates
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  confirmed_at TIMESTAMPTZ,
  cancelled_at TIMESTAMPTZ
);

CREATE INDEX idx_bookings_listing ON bookings(listing_id);
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_bookings_dates ON bookings(check_in, check_out);

-- ============================================
-- TABLE: reviews
-- Avis et évaluations
-- ============================================
CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
  listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  reviewer_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  reviewee_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  -- Évaluation
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  
  -- Catégories d'évaluation
  cleanliness_rating INTEGER CHECK (cleanliness_rating >= 1 AND cleanliness_rating <= 5),
  communication_rating INTEGER CHECK (communication_rating >= 1 AND communication_rating <= 5),
  location_rating INTEGER CHECK (location_rating >= 1 AND location_rating <= 5),
  value_rating INTEGER CHECK (value_rating >= 1 AND value_rating <= 5),
  
  -- IA
  ai_summary TEXT, -- Résumé généré par Gemini
  sentiment_score DECIMAL(3, 2), -- Score de sentiment (-1 à 1)
  
  -- Dates
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_reviews_listing ON reviews(listing_id);
CREATE INDEX idx_reviews_reviewer ON reviews(reviewer_id);

-- ============================================
-- TABLE: favorites
-- Favoris utilisateurs
-- ============================================
CREATE TABLE favorites (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(user_id, listing_id)
);

CREATE INDEX idx_favorites_user ON favorites(user_id);

-- ============================================
-- TABLE: messages
-- Messagerie entre utilisateurs
-- ============================================
CREATE TABLE messages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
  sender_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  receiver_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_messages_booking ON messages(booking_id);
CREATE INDEX idx_messages_participants ON messages(sender_id, receiver_id);

-- ============================================
-- TABLE: ai_recommendations
-- Recommandations générées par IA
-- ============================================
CREATE TABLE ai_recommendations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  listing_id UUID REFERENCES listings(id) ON DELETE CASCADE,
  
  recommendation_type TEXT NOT NULL CHECK (recommendation_type IN ('listing', 'activity', 'itinerary', 'general')),
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  confidence_score DECIMAL(3, 2), -- 0 à 1
  
  -- Contexte de la recommandation
  context JSONB, -- Préférences, historique, etc.
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  viewed_at TIMESTAMPTZ,
  clicked_at TIMESTAMPTZ
);

CREATE INDEX idx_ai_recommendations_user ON ai_recommendations(user_id);

-- ============================================
-- TABLE: ai_chat_history
-- Historique des conversations avec le chatbot
-- ============================================
CREATE TABLE ai_chat_history (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  user_message TEXT NOT NULL,
  ai_response TEXT NOT NULL,
  prompt_used TEXT, -- Prompt Gemini utilisé
  tokens_used INTEGER,
  
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_ai_chat_user ON ai_chat_history(user_id);

-- ============================================
-- TABLE: availability
-- Calendrier de disponibilité
-- ============================================
CREATE TABLE availability (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  listing_id UUID NOT NULL REFERENCES listings(id) ON DELETE CASCADE,
  
  date DATE NOT NULL,
  is_available BOOLEAN DEFAULT true,
  price_override DECIMAL(10, 2), -- Prix spécial pour cette date
  
  UNIQUE(listing_id, date)
);

CREATE INDEX idx_availability_listing_date ON availability(listing_id, date);

-- ============================================
-- TABLE: notifications
-- Notifications utilisateurs
-- ============================================
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  
  type TEXT NOT NULL CHECK (type IN ('booking', 'message', 'review', 'system', 'ai_recommendation')),
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  data JSONB, -- Données additionnelles
  
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_unread ON notifications(user_id, is_read) WHERE is_read = false;

-- ============================================
-- FUNCTIONS & TRIGGERS
-- ============================================

-- Fonction pour mettre à jour updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers pour updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_listings_updated_at BEFORE UPDATE ON listings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_bookings_updated_at BEFORE UPDATE ON bookings
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Fonction pour calculer la moyenne des ratings
CREATE OR REPLACE FUNCTION update_listing_rating()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE listings
  SET 
    rating_average = (
      SELECT AVG(rating)::DECIMAL(3,2)
      FROM reviews
      WHERE listing_id = NEW.listing_id
    ),
    review_count = (
      SELECT COUNT(*)
      FROM reviews
      WHERE listing_id = NEW.listing_id
    )
  WHERE id = NEW.listing_id;
  
  RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_listing_rating_trigger
  AFTER INSERT OR UPDATE ON reviews
  FOR EACH ROW EXECUTE FUNCTION update_listing_rating();

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Activer RLS sur toutes les tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE listings ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_recommendations ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_chat_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE availability ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Policies pour profiles
CREATE POLICY "Users can view all profiles"
  ON profiles FOR SELECT
  USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- Policies pour listings
CREATE POLICY "Anyone can view active listings"
  ON listings FOR SELECT
  USING (status = 'active');

CREATE POLICY "Hosts can manage own listings"
  ON listings FOR ALL
  USING (auth.uid() = host_id);

-- Policies pour bookings
CREATE POLICY "Users can view own bookings"
  ON bookings FOR SELECT
  USING (auth.uid() = guest_id OR auth.uid() = (SELECT host_id FROM listings WHERE id = listing_id));

CREATE POLICY "Users can create bookings"
  ON bookings FOR INSERT
  WITH CHECK (auth.uid() = guest_id);

CREATE POLICY "Hosts can update bookings for their listings"
  ON bookings FOR UPDATE
  USING (auth.uid() = (SELECT host_id FROM listings WHERE id = listing_id));

-- Policies pour reviews
CREATE POLICY "Anyone can view reviews"
  ON reviews FOR SELECT
  USING (true);

CREATE POLICY "Users can create reviews for their bookings"
  ON reviews FOR INSERT
  WITH CHECK (
    auth.uid() = reviewer_id AND
    EXISTS (
      SELECT 1 FROM bookings
      WHERE id = booking_id AND guest_id = auth.uid()
    )
  );

-- Policies pour favorites
CREATE POLICY "Users can manage own favorites"
  ON favorites FOR ALL
  USING (auth.uid() = user_id);

-- Policies pour messages
CREATE POLICY "Users can view own messages"
  ON messages FOR SELECT
  USING (auth.uid() = sender_id OR auth.uid() = receiver_id);

CREATE POLICY "Users can send messages"
  ON messages FOR INSERT
  WITH CHECK (auth.uid() = sender_id);

-- Policies pour ai_recommendations
CREATE POLICY "Users can view own recommendations"
  ON ai_recommendations FOR SELECT
  USING (auth.uid() = user_id);

-- Policies pour ai_chat_history
CREATE POLICY "Users can view own chat history"
  ON ai_chat_history FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can create own chat history"
  ON ai_chat_history FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Policies pour notifications
CREATE POLICY "Users can view own notifications"
  ON notifications FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can update own notifications"
  ON notifications FOR UPDATE
  USING (auth.uid() = user_id);

