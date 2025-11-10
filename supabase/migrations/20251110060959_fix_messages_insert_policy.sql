/*
  # Fix Messages Insert Policy

  1. Changes
    - Drop overly restrictive INSERT policy on messages
    - Create a simpler policy that allows users to insert messages in their own conversations
    
  2. Security
    - Users can only insert messages in conversations they own or where they are admins
    - Maintains proper RLS enforcement
*/

DROP POLICY IF EXISTS "Users can create messages in their conversations" ON messages;

CREATE POLICY "Users can create messages in their conversations"
  ON messages
  FOR INSERT
  TO authenticated
  WITH CHECK (
    auth.uid() = sender_id
    AND EXISTS (
      SELECT 1 FROM conversations
      WHERE conversations.id = messages.conversation_id
      AND (conversations.user_id = auth.uid() OR EXISTS (
        SELECT 1 FROM admin_users
        WHERE admin_users.user_id = auth.uid()
      ))
    )
  );

-- Ensure DELETE policy for conversations cascade works
DROP POLICY IF EXISTS "Conversations can be deleted by admins" ON conversations;

CREATE POLICY "Admins can delete conversations"
  ON conversations
  FOR DELETE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM admin_users
      WHERE admin_users.user_id = auth.uid()
    )
  );
