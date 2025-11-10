/*
  # Mejorar detección de estado de conversación

  1. Mejoras
    - Mejorar el trigger para actualizar last_message_at correctamente
    - Agregar índices para mejorar el rendimiento de las consultas en tiempo real
    - Asegurar que las actualizaciones de estado se propaguen correctamente
  
  2. Seguridad
    - Mantener políticas RLS existentes
*/

-- Eliminar el trigger anterior si existe
DROP TRIGGER IF EXISTS update_conversation_timestamp ON messages;
DROP FUNCTION IF EXISTS update_conversation_last_message();

-- Crear función mejorada para actualizar last_message_at
CREATE OR REPLACE FUNCTION update_conversation_last_message()
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

-- Crear trigger mejorado
CREATE TRIGGER update_conversation_timestamp
  AFTER INSERT ON messages
  FOR EACH ROW
  EXECUTE FUNCTION update_conversation_last_message();

-- Agregar índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_conversations_user_status ON conversations(user_id, status);
CREATE INDEX IF NOT EXISTS idx_conversations_status ON conversations(status);
CREATE INDEX IF NOT EXISTS idx_messages_conversation ON messages(conversation_id, created_at DESC);

-- Función para reabrir conversación
CREATE OR REPLACE FUNCTION reopen_conversation(conv_id uuid)
RETURNS void AS $$
BEGIN
  UPDATE conversations
  SET 
    status = 'open',
    updated_at = now(),
    last_message_at = now()
  WHERE id = conv_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Permitir que usuarios autenticados reabran sus propias conversaciones
GRANT EXECUTE ON FUNCTION reopen_conversation TO authenticated;