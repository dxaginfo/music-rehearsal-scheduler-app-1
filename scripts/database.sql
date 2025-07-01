-- Postgres schema for rehearsal scheduler
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(128) NOT NULL UNIQUE,
  name VARCHAR(100),
  password_hash TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE groups (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  admin_id INTEGER REFERENCES users(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE members (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  user_id INTEGER REFERENCES users(id),
  role VARCHAR(20)
);
CREATE TABLE rehearsals (
  id SERIAL PRIMARY KEY,
  group_id INTEGER REFERENCES groups(id),
  scheduled_time TIMESTAMP,
  status VARCHAR(20),
  location VARCHAR(100),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE availability (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  available BOOLEAN
);
CREATE TABLE attendance (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  user_id INTEGER REFERENCES users(id),
  status VARCHAR(20)
);
CREATE TABLE payments (
  id SERIAL PRIMARY KEY,
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  user_id INTEGER REFERENCES users(id),
  amount DECIMAL,
  status VARCHAR(20)
);
CREATE TABLE notifications (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  text TEXT,
  sent_at TIMESTAMP,
  method VARCHAR(20)
);
CREATE TABLE equipment (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  notes TEXT,
  status VARCHAR(20)
);
CREATE TABLE reservations (
  id SERIAL PRIMARY KEY,
  equipment_id INTEGER REFERENCES equipment(id),
  rehearsal_id INTEGER REFERENCES rehearsals(id),
  user_id INTEGER REFERENCES users(id)
);
