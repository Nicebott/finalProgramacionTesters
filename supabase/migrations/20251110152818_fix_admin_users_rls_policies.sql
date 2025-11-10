/*
  # Arreglar políticas RLS de admin_users

  Simplificar las políticas RLS para evitar subconsultas circulares que causan errores 500.
  Las políticas ahora son más directas y eficientes.
*/

-- Eliminar todas las políticas existentes
DROP POLICY IF EXISTS "Users can check their own admin status" ON admin_users;
DROP POLICY IF EXISTS "Admins can view all admin users" ON admin_users;
DROP POLICY IF EXISTS "Admins can insert admin users" ON admin_users;

-- Política simple: cada usuario puede ver su propio registro
CREATE POLICY "Users can view own admin record"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Los usuarios autenticados pueden ver registros de admins (para verificación)
CREATE POLICY "Anyone can view admin records"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (true);
