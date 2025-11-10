/*
  # Fix Admin Panel and Realtime Chat Issues

  1. Changes
    - Fix admin_users table policies to allow users to check their own admin status
    - Add trigger to update last_message_at in conversations when messages are inserted
    - Enable replica identity for realtime updates
    
  2. Security
    - Users can only check if they themselves are admin
    - Maintains restrictive RLS policies
*/

-- Drop existing policies on admin_users
DROP POLICY IF EXISTS "Admins can view all admin users" ON admin_users;
DROP POLICY IF EXISTS "Only admins can insert admin users" ON admin_users;

-- Create new policy that allows users to check their own admin status
CREATE POLICY "Users can check their own admin status"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Create policy for admins to view all admin users
CREATE POLICY "Admins can view all admin users"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE admin_users.user_id = auth.uid()
    )
  );

-- Create policy for admins to insert new admin users
CREATE POLICY "Admins can insert admin users"
  ON admin_users
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE admin_users.user_id = auth.uid()
    )
  );

-- Create trigger function to update last_message_at
CREATE OR REPLACE FUNCTION update_conversation_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE conversations
  SET 
    last_message_at = NEW.created_at,
    updated_at = NEW.created_at
  WHERE id = NEW.conversation_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop trigger if exists
DROP TRIGGER IF EXISTS update_conversation_on_message ON messages;

-- Create trigger on messages
CREATE TRIGGER update_conversation_on_message
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE FUNCTION update_conversation_timestamp();

-- Enable replica identity for realtime
ALTER TABLE conversations REPLICA IDENTITY FULL;
ALTER TABLE messages REPLICA IDENTITY FULL;

-- Grant necessary permissions for realtime
GRANT SELECT ON conversations TO authenticated;
GRANT SELECT ON messages TO authenticated;
