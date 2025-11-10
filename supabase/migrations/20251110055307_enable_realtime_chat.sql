/*
  # Enable Realtime for Chat System

  1. Changes
    - Enable realtime publication for conversations and messages tables
    - This allows real-time subscriptions to work properly

  2. Security
    - Maintains existing RLS policies
    - Only enables realtime listening capabilities
*/

-- Enable realtime for conversations table
ALTER PUBLICATION supabase_realtime ADD TABLE conversations;

-- Enable realtime for messages table
ALTER PUBLICATION supabase_realtime ADD TABLE messages;
