-- Insert roles if they do not exist
INSERT INTO roles (role_name)
VALUES ('admin'), ('member'), ('trainer')
ON CONFLICT (role_name) DO NOTHING;

-- Insert trainers
-- generation of hashed password handled externally
-- Replace `hashed_password` with actual hashed passwords
WITH new_users AS (
  INSERT INTO users (first_name, last_name, email, password, phone_number, address)
  VALUES
    ('John', 'Doe', 'john@doe.com', 'hashed_password', '1234567890', 'doe street'),
    ('Jane', 'Smith', 'jane@smith.com', 'hashed_password', '1234567890', 'jane street'),
    ('Jim', 'Bean', 'jim@bean.com', 'hashed_password', '1234567890', 'bean street')
  ON CONFLICT (email) DO NOTHING
  RETURNING user_id
)
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 3 FROM new_users;

-- Insert members
-- Repeat the process as with trainers, changing role_id to 2 for members
WITH new_members AS (
  INSERT INTO users (first_name, last_name, email, password, phone_number, address)
  VALUES
    ('maxime', 'gagne', 'max@gagne.com', 'hashed_password', '1234567890', 'doe street'),
    ('vincent', 'gagnon', 'vincent@gagnon.com', 'hashed_password', '1234567890', '5 vince street'),
    ('Joe', 'rich', 'joe@rich.com', 'hashed_password', '1234567890', '2 rich street')
  ON CONFLICT (email) DO NOTHING
  RETURNING user_id
)
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 2 FROM new_members;

-- Insert admin
WITH admin_user AS (
  INSERT INTO users (first_name, last_name, email, password, phone_number, address)
  VALUES ('admin', 'admin', 'admin@admin.com', 'hashed_password', '1234567890', 'admin street')
  ON CONFLICT (email) DO NOTHING
  RETURNING user_id
)
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 1 FROM admin_user;

-- Insert equipment if they do not exist
INSERT INTO equipment (equipment_id, equipment_name, last_maintained, next_maintained)
VALUES
  (1, 'smith machine', '2023-09-01', '2024-09-01'),
  (2, 'bench', '2023-09-01', '2030-09-01'),
  (3, 'leg press', '2023-09-01', '2025-09-01')
ON CONFLICT (equipment_id) DO NOTHING;
