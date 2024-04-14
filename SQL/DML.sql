-- Insert roles if they do not exist
INSERT INTO roles (role_name)
VALUES ('admin'), ('member'), ('trainer')
ON CONFLICT (role_name) DO NOTHING;

-- Insert trainers
-- generation of hashed password handled externally
-- Replace `hashed_password` with actual hashed passwords
WITH new_trainers (first_name, last_name, email, password, phone_number, address) AS (
    VALUES
    ('John', 'Doe', 'john@doe.com', 'hashedPassword', '1234567890', 'doe street'),
    ('Jane', 'Smith', 'jane@smith.com', 'hashedPassword', '1234567890', 'jane street'),
    ('Jim', 'Bean', 'jim@bean.com', 'hashedPassword', '1234567890', 'bean street')
),
inserted AS (
    INSERT INTO users (first_name, last_name, email, password, phone_number, address)
    SELECT first_name, last_name, email, password, phone_number, address FROM new_trainers
    WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = new_trainers.email)
    RETURNING user_id -- this returns the ids of the newly inserted users
)
-- Step 2: Insert new roles for these users into 'userRoles' and mark them as trainers in 'trainer' table
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 3 FROM inserted;  -- Assuming the role_id for trainers is 3

INSERT INTO trainer (user_id)
SELECT user_id FROM inserted;

-- Insert members
-- Repeat the process as with trainers, changing role_id to 2 for members
ITH new_members (first_name, last_name, email, password, phone_number, address) AS (
    VALUES
    ('Maxime', 'Gagne', 'max@gagne.com', 'hashedPassword', '1234567890', 'doe street'),
    ('Vincent', 'Gagnon', 'vincent@gagnon.com', 'hashedPassword', '1234567890', '5 vince street'),
    ('Joe', 'Rich', 'joe@rich.com', 'hashedPassword', '1234567890', '2 rich street'),
    ('Alice', 'Miller', 'alice@miller.com', 'hashedPassword', '3612988024', 'Magnolia street'),
    ('Irene', 'Jones', 'irene@jones.com', 'hashedPassword', '8775332651', 'Elm street'),
    ('Eve', 'Taylor', 'eve@taylor.com', 'hashedPassword', '4284698279', 'Aspen street'),
    ('Carol', 'Anderson', 'carol@anderson.com', 'hashedPassword', '1188393902', 'Cedar street'),
    ('Bob', 'Jones', 'bob@jones.com', 'hashedPassword', '8353281714', 'Maple street'),
    ('Alice', 'Anderson', 'alice@anderson.com', 'hashedPassword', '7875440352', 'Oak street'),
    ('Frank', 'Johnson', 'frank@johnson.com', 'hashedPassword', '4439907352', 'Willow street'),
    ('Jack', 'Brown', 'jack@brown.com', 'hashedPassword', '0135968549', 'Elm street'),
    ('Irene', 'Moore', 'irene@moore.com', 'hashedPassword', '2794474148', 'Oak street'),
    ('Hank', 'Brown', 'hank@brown.com', 'hashedPassword', '3409510607', 'Birch street')
),
inserted AS (
    INSERT INTO users (first_name, last_name, email, password, phone_number, address)
    SELECT first_name, last_name, email, password, phone_number, address FROM new_members
    WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = new_members.email)
    RETURNING user_id  -- Capture the user_id of the newly inserted members to use in subsequent inserts
)

-- Insert into userRoles table, assuming role_id for members is 2
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 2 FROM inserted;

-- Insert additional member details into the 'members' table
INSERT INTO members (user_id, health_metric, fitness_goals, fitness_achievements, join_date)
SELECT user_id, '', '', '', TO_CHAR(NOW() :: DATE, 'yyyy-mm-dd') FROM inserted;

-- Insert admin
WITH new_admin (first_name, last_name, email, password, phone_number, address) AS (
    VALUES
    ('admin', 'admin', 'admin@admin.com', 'hashedPassword', '1234567890', 'admin street')
),
-- Insert admin if they do not already exist
inserted AS (
    INSERT INTO users (first_name, last_name, email, password, phone_number, address)
    SELECT first_name, last_name, email, password, phone_number, address FROM new_admin
    WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = new_admin.email)
    RETURNING user_id -- Capture the user_id of the newly inserted admin to use in subsequent inserts
)

-- Insert into userRoles table, assuming role_id for admin is 1
INSERT INTO userRoles (user_id, role_id)
SELECT user_id, 1 FROM inserted;

-- Insert admin specific information into adminStaff table
INSERT INTO adminStaff (user_id)
SELECT user_id FROM inserted;

-- Insert equipment if they do not exist
WITH new_equipment (equipment_id, equipment_name, last_maintained, next_maintained) AS (
    VALUES
    (1, 'smith machine', '2023-09-01', '2024-09-01'),
    (2, 'bench', '2023-09-01', '2030-09-01'),
    (3, 'leg press', '2023-09-01', '2025-09-01')
),
-- Attempt to insert new equipment records if they do not already exist
inserted AS (
    INSERT INTO equipments (equipment_id, equipment_name, last_maintained, next_maintained)
    SELECT equipment_id, equipment_name, last_maintained, next_maintained FROM new_equipment
    WHERE NOT EXISTS (SELECT 1 FROM equipments WHERE equipment_id = new_equipment.equipment_id)
    RETURNING equipment_id -- Optional: capture the equipment_id of the newly inserted equipment
)

WITH new_rooms (room_name, room_capacity) AS (
    VALUES
    ('main room', 100),
    ('cardio room', 100),
    ('weight room', 100)
),
-- Insert new room records if they do not already exist
inserted AS (
    INSERT INTO rooms (room_name, room_capacity)
    SELECT room_name, room_capacity FROM new_rooms
    WHERE NOT EXISTS (SELECT 1 FROM rooms WHERE room_name = new_rooms.room_name)
    RETURNING room_name  -- This line is optional, it can be useful for debugging or logging purposes
)
-- Insert routines
WITH new_routines (routine_name) AS (
    VALUES
    ('My first routine'),
    ('Advance routine'),
    ('Best routine')
),
-- Attempt to insert new routines if they do not already exist
inserted AS (
    INSERT INTO routine (routine_name)
    SELECT routine_name FROM new_routines
    WHERE NOT EXISTS (
        SELECT 1 FROM routine WHERE routine_name = new_routines.routine_name
    )
    RETURNING routine_name  -- This line is optional, useful for debugging or logging
)

WITH new_mappings (routine_id, exercise_id) AS (
    VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (1, 4),
    (2, 1)
),
-- Attempt to insert new mappings if they do not already exist
inserted AS (
    INSERT INTO routineExercise (routine_id, exercise_id)
    SELECT routine_id, exercise_id FROM new_mappings
    WHERE NOT EXISTS (
        SELECT 1 FROM routineExercise
        WHERE routine_id = new_mappings.routine_id AND exercise_id = new_mappings.exercise_id
    )
    RETURNING routine_id, exercise_id  -- This line is optional, useful for debugging or logging
)

WITH new_time_slots (title, trainer_id, start_time, end_time, current_enrollment, capacity, room, price) AS (
    VALUES
    ('Morning Session', 1, '2024-04-07 07:00:00', '2024-04-07 09:00:00', 0, 50, 'Room 101', 0),
    ('Midday Session', 1, '2024-04-07 11:00:00', '2024-04-07 13:00:00', 0, 60, 'Room 102', 10),
    ('Afternoon Session', 1, '2024-04-07 15:00:00', '2024-04-07 17:00:00', 0, 70, 'Room 103', 15),
    ('Evening Session', 1, '2024-04-07 19:00:00', '2024-04-07 21:00:00', 0, 80, 'Room 104', 20),
    ('Morning Session 2', 2, '2024-04-08 07:00:00', '2024-04-08 09:00:00', 0, 50, 'Room 105', 0),
    ('Midday Session 2', 2, '2024-04-08 11:00:00', '2024-04-08 13:00:00', 0, 60, 'Room 106', 10),
    ('Afternoon Session 2', 2, '2024-04-08 15:00:00', '2024-04-08 17:00:00', 0, 70, 'Room 107', 15),
    ('Evening Session 2', 3, '2024-04-08 19:00:00', '2024-04-08 21:00:00', 0, 80, 'Room 108', 20),
    ('Morning Session 3', 3, '2024-04-09 07:00:00', '2024-04-09 09:00:00', 0, 50, 'Room 109', 0),
    ('Midday Session 3', 3, '2024-04-09 11:00:00', '2024-04-09 13:00:00', 0, 60, 'Room 110', 10)
),
-- Attempt to insert new time slots if they do not already exist
inserted AS (
    INSERT INTO timeSlots (title, trainer_id, start_time, end_time, current_enrollment, capacity, location, price)
    SELECT title, trainer_id, start_time, end_time, current_enrollment, capacity, room, price FROM new_time_slots
    WHERE NOT EXISTS (
        SELECT 1 FROM timeSlots WHERE title = new_time_slots.title
    )
    RETURNING title  -- This line is optional, useful for debugging or logging
)

WITH new_user_routines (user_id, routine_id) AS (
    VALUES
    (1, 1),
    (2, 2)
),
-- Insert new user-routine mappings if they do not already exist
inserted AS (
    INSERT INTO userRoutine (user_id, routine_id)
    SELECT user_id, routine_id FROM new_user_routines
    WHERE NOT EXISTS (
        SELECT 1 FROM userRoutine
        WHERE user_id = new_user_routines.user_id AND routine_id = new_user_routines.routine_id
    )
    RETURNING user_id, routine_id  -- This line is optional, useful for debugging or logging
)