/*
  # Agregar columna is_admin y actualizar políticas RLS

  1. Cambios
    - Agregar columna `is_admin` a `admin_users` con valor por defecto `false`
    - Actualizar registros existentes para marcarlos como admin
    - Mejorar las políticas RLS para usar la columna `is_admin`

  2. Seguridad
    - Los usuarios solo pueden ver su propio estado de admin
    - Solo los admins pueden ver todos los registros
    - Solo los admins pueden insertar nuevos admin_users
*/

-- Agregar columna is_admin si no existe
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns
    WHERE table_name = 'admin_users' AND column_name = 'is_admin'
  ) THEN
    ALTER TABLE admin_users ADD COLUMN is_admin boolean DEFAULT false;
  END IF;
END $$;

-- Marcar todos los usuarios existentes como admins
UPDATE admin_users
SET is_admin = true
WHERE is_admin IS NULL OR is_admin = false;

-- Eliminar políticas existentes
DROP POLICY IF EXISTS "Users can check their own admin status" ON admin_users;
DROP POLICY IF EXISTS "Admins can view all admin users" ON admin_users;
DROP POLICY IF EXISTS "Admins can insert admin users" ON admin_users;

-- Los usuarios pueden ver su propio registro
CREATE POLICY "Users can check their own admin status"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (user_id = auth.uid());

-- Los administradores pueden ver todos los registros
CREATE POLICY "Admins can view all admin users"
  ON admin_users
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM admin_users AS a
      WHERE a.user_id = auth.uid() AND a.is_admin = true
    )
  );

-- Solo los administradores pueden insertar nuevos admin_users
CREATE POLICY "Admins can insert admin users"
  ON admin_users
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM admin_users AS a
      WHERE a.user_id = auth.uid() AND a.is_admin = true
    )
  );
