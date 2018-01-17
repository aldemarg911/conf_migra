/* Formatted on 16/01/2016 12:33 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
DECLARE
   CURSOR c_tab IS
      SELECT DISTINCT table_name
                 FROM all_tab_columns
                WHERE column_name IN('SSEGURO', 'NRECIBO', 'SPROCES', 'NRIESGO', 'SPERSON', 'NSINIES');

   filas          NUMBER;
   err            NUMBER;
BEGIN
   SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(17, 'USER_BBDD'))
     INTO err
     FROM DUAL;

   FOR t IN c_tab LOOP
      EXECUTE IMMEDIATE 'BEGIN SELECT COUNT(1) INTO :FILAS FROM ' || t.table_name || '; END;'
                  USING OUT filas;

      IF filas > 0 THEN
         DBMS_OUTPUT.put_line('Tabla: ' || t.table_name || ' con ' || filas || ' filas');
      --dbms_output.put_line ('DELETE FROM '||  t.table_name || ';');
      END IF;
   END LOOP;
END;
/