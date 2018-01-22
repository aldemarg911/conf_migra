DECLARE
vmodulos CLOB;
BEGIN
vmodulos := '
leeme.txt
sql\01_migra_usuarios_conf_479.sql
sql\refresh_web_persistencia.wql
';
  -- INSERT DEL LOG DEL PATCH
  INSERT INTO LOG_INSTALACION( FECHA, USUARIO, ERROR,CODIGO,TITULO,MODULOS)
  values      ( F_SYSDATE,F_USER,NULL,'CONF_479',' MIgración de usuarios',vmodulos);
END;
/
