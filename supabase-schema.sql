-- This SQL script creates the necessary tables for the Thai travel photo site
-- You can run this in the Supabase SQL Editor to set up your database schema

-- Create profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  bio TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create locations table
CREATE TABLE IF NOT EXISTS locations (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  province TEXT NOT NULL,
  description TEXT,
  latitude DECIMAL,
  longitude DECIMAL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create photos table
CREATE TABLE IF NOT EXISTS photos (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  image_url TEXT NOT NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  location_id INTEGER REFERENCES locations(id),
  category_id INTEGER REFERENCES categories(id),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create likes table
CREATE TABLE IF NOT EXISTS likes (
  id SERIAL PRIMARY KEY,
  photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(photo_id, user_id)
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
  id SERIAL PRIMARY KEY,
  content TEXT NOT NULL,
  photo_id INTEGER REFERENCES photos(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create trigger to automatically create a profile when a new user signs up
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, username, full_name, avatar_url, created_at)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'username', 'user_' || substr(NEW.id::text, 1, 8)),
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.raw_user_meta_data->>'username', 'New User'),
    NULL,
    NOW()
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Create trigger
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();

-- Insert sample data for categories
INSERT INTO categories (name, description) VALUES
('ชายหาด', 'สถานที่ท่องเที่ยวประเภทชายหาด ทะเล และเกาะ'),
('ภูเขา', 'สถานที่ท่องเที่ยวประเภทภูเขา น้ำตก และธรรมชาติ'),
('วัด', 'สถานที่ท่องเที่ยวประเภทวัด โบราณสถาน และสถานที่ศักดิ์สิทธิ์'),
('เมือง', 'สถานที่ท่องเที่ยวในเมือง สถาปัตยกรรม และแหล่งช้อปปิ้ง'),
('วัฒนธรรม', 'สถานที่ท่องเที่ยวทางวัฒนธรรม ประเพณี และวิถีชีวิต')
ON CONFLICT DO NOTHING;

-- Insert sample data for locations
INSERT INTO locations (name, province, description) VALUES
('หาดพัทยา', 'ชลบุรี', 'หาดพัทยาเป็นหาดที่มีชื่อเสียงและเป็นที่นิยมของนักท่องเที่ยวทั้งชาวไทยและชาวต่างชาติ'),
('วัดพระแก้ว', 'กรุงเทพมหานคร', 'วัดพระศรีรัตนศาสดาราม หรือวัดพระแก้ว เป็นวัดที่มีความสำคัญในประวัติศาสตร์ไทย'),
('ดอยอินทนนท์', 'เชียงใหม่', 'ดอยอินทนนท์เป็นยอดเขาที่สูงที่สุดในประเทศไทย มีความสูง 2,565 เมตรจากระดับน้ำทะเล'),
('เกาะพีพี', 'กระบี่', 'เกาะพีพีเป็นหมู่เกาะที่มีชื่อเสียงในจังหวัดกระบี่ ประกอบด้วยเกาะ 6 เกาะ'),
('อุทยานแห่งชาติเขาใหญ่', 'นครราชสีมา', 'อุทยานแห่งชาติเขาใหญ่เป็นมรดกโลกทางธรรมชาติแห่งแรกของประเทศไทย'),
('ตลาดน้ำดำเนินสะดวก', 'ราชบุรี', 'ตลาดน้ำดำเนินสะดวกเป็นตลาดน้ำที่มีชื่อเสียงและเก่าแก่ที่สุดแห่งหนึ่งของประเทศไทย')
ON CONFLICT DO NOTHING;
