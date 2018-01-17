/* Formatted on 16/01/2016 12:33 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
declare
  Cursor c_tab IS
    SELECT table_name
      FROM USER_TABLES
      WHERE TABLESPACE_NAME IS NOT NULL
        AND INSTR (table_name, '$') = 0;
      
  filas number;
begin
  FOR t in c_tab LOOP
    EXECUTE IMMEDIATE 'BEGIN SELECT COUNT(1) INTO :FILAS FROM '||t.table_name ||'; END;' USING OUT filas;
    
    IF filas > 0 THEN
      dbms_output.put_line ('Tabla: '||  t.table_name || ' con '|| filas||' filas');
      -- dbms_output.put_line ('DELETE FROM '||  t.table_name || ';');
    END IF; 
  END LOOP;
end;
/