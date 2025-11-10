/*
  # Add function to get user emails

  1. Changes
    - Create a function to get user email by user_id
    - This allows admins to see user emails in conversations

  2. Security
    - Only accessible to authenticated users
    - Returns email from auth.users
*/

-- Create function to get user email
CREATE OR REPLACE FUNCTION get_user_email(user_uuid uuid)
RETURNS text
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  user_email text;
BEGIN
  SELECT email INTO user_email
  FROM auth.users
  WHERE id = user_uuid;
  
  RETURN COALESCE(user_email, 'Unknown');
END;
$$;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION get_user_email(uuid) TO authenticated;
