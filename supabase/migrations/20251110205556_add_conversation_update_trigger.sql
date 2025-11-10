/*
  # Add automatic conversation update trigger
  
  1. Changes
    - Creates a trigger function to automatically update `last_message_at` and `updated_at` 
      in the conversations table when a new message is inserted
    - This ensures the admin panel receives real-time updates when new messages arrive
    
  2. Benefits
    - Conversations automatically update their timestamp when messages are added
    - Admin panel can show conversations sorted by most recent activity
    - No manual updates needed in application code
*/

-- Create function to update conversation timestamps
CREATE OR REPLACE FUNCTION update_conversation_on_message()
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

-- Create trigger on messages table
DROP TRIGGER IF EXISTS trigger_update_conversation ON messages;

CREATE TRIGGER trigger_update_conversation
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE FUNCTION update_conversation_on_message();