-- Supabase Setup Script for Planner App

-- 1. Create tasks table if it doesn't exist
CREATE TABLE IF NOT EXISTS tasks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  title text NOT NULL,
  note text,
  time text,
  priority text NOT NULL,
  repeat text NOT NULL,
  emoji text NOT NULL,
  tags text[],
  completed boolean DEFAULT FALSE NOT NULL,
  "order" integer NOT NULL,
  date_str text NOT NULL,
  inserted_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Enable RLS on tasks table
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;

-- 3. Create Policy: Users can only access their own tasks
CREATE POLICY "Users can only access their own tasks" 
ON tasks 
FOR ALL 
USING (auth.uid() = user_id);

-- 4. Create Indexes for performance
CREATE INDEX IF NOT EXISTS idx_tasks_user_id ON tasks(user_id);
CREATE INDEX IF NOT EXISTS idx_tasks_user_date ON tasks(user_id, date_str);

-- 5. Unique constraint for upsert (if not already present)
ALTER TABLE tasks ADD CONSTRAINT tasks_id_key UNIQUE (id);
