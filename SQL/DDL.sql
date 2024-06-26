CREATE TABLE IF NOT EXISTS "adminStaff" (
	"user_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "billingInformation" (
	"billing_id" serial PRIMARY KEY NOT NULL,
	"user_id" integer,
	"periodicity" text NOT NULL,
	"cardType" text,
	"cardHolder" text NOT NULL,
	"cardNumber" text NOT NULL,
	"expiry" date NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "bookings" (
	"user_id" integer,
	"slot_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "equipment" (
	"equipment_id" serial PRIMARY KEY NOT NULL,
	"equipment_name" text,
	"last_maintained" date NOT NULL,
	"next_maintained" date NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "exercises" (
	"exercise_id" serial PRIMARY KEY NOT NULL,
	"exercise_name" text,
	"reps" integer,
	"duration" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "member" (
	"user_id" integer,
	"health_metric" text,
	"fitness_goals" text,
	"fitness_achievements" text,
	"join_date" date
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "paymentInfo" (
	"payment_id" serial PRIMARY KEY NOT NULL,
	"user_id" integer,
	"payment_date" date,
	"amount" integer,
	"slot_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "roles" (
	"role_id" serial PRIMARY KEY NOT NULL,
	"role_name" text NOT NULL,
	CONSTRAINT "roles_role_name_unique" UNIQUE("role_name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "rooms" (
	"room_id" serial PRIMARY KEY NOT NULL,
	"room_name" text NOT NULL,
	"room_capacity" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "routine" (
	"routine_id" serial PRIMARY KEY NOT NULL,
	"routine_name" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "routineExercise" (
	"routine_id" integer,
	"exercise_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "timeSlots" (
	"slot_id" serial PRIMARY KEY NOT NULL,
	"title" text NOT NULL,
	"trainer_id" integer NOT NULL,
	"start_time" timestamp NOT NULL,
	"end_time" timestamp NOT NULL,
	"current_enrollment" integer NOT NULL,
	"capacity" integer NOT NULL,
	"room" integer,
	"price" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "trainer" (
	"user_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "userRoles" (
	"user_id" integer,
	"role_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "userRoutine" (
	"user_id" integer,
	"routine_id" integer
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"user_id" serial PRIMARY KEY NOT NULL,
	"first_name" text NOT NULL,
	"last_name" text NOT NULL,
	"email" text NOT NULL,
	"password" text NOT NULL,
	"phone_number" text,
	"address" text,
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "adminStaff" ADD CONSTRAINT "adminStaff_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "billingInformation" ADD CONSTRAINT "billingInformation_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bookings" ADD CONSTRAINT "bookings_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "bookings" ADD CONSTRAINT "bookings_slot_id_timeSlots_slot_id_fk" FOREIGN KEY ("slot_id") REFERENCES "timeSlots"("slot_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "member" ADD CONSTRAINT "member_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "paymentInfo" ADD CONSTRAINT "paymentInfo_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "paymentInfo" ADD CONSTRAINT "paymentInfo_slot_id_timeSlots_slot_id_fk" FOREIGN KEY ("slot_id") REFERENCES "timeSlots"("slot_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "routineExercise" ADD CONSTRAINT "routineExercise_routine_id_routine_routine_id_fk" FOREIGN KEY ("routine_id") REFERENCES "routine"("routine_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "routineExercise" ADD CONSTRAINT "routineExercise_exercise_id_exercises_exercise_id_fk" FOREIGN KEY ("exercise_id") REFERENCES "exercises"("exercise_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "timeSlots" ADD CONSTRAINT "timeSlots_room_rooms_room_id_fk" FOREIGN KEY ("room") REFERENCES "rooms"("room_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "trainer" ADD CONSTRAINT "trainer_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userRoles" ADD CONSTRAINT "userRoles_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userRoles" ADD CONSTRAINT "userRoles_role_id_roles_role_id_fk" FOREIGN KEY ("role_id") REFERENCES "roles"("role_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userRoutine" ADD CONSTRAINT "userRoutine_user_id_users_user_id_fk" FOREIGN KEY ("user_id") REFERENCES "users"("user_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userRoutine" ADD CONSTRAINT "userRoutine_routine_id_routine_routine_id_fk" FOREIGN KEY ("routine_id") REFERENCES "routine"("routine_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
