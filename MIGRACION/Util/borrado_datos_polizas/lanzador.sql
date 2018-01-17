 set termout off  
 set define ':' 
 COLUMN X NEW_VALUE Y  
 SELECT SUBSTR (SYS.DBMS_STANDARD.DATABASE_NAME, 1, CASE WHEN INSTR (SYS.DBMS_STANDARD.DATABASE_NAME, '.') = 0 THEN LENGTH (SYS.DBMS_STANDARD.DATABASE_NAME) ELSE INSTR (SYS.DBMS_STANDARD.DATABASE_NAME, '.') - 1  END) X  FROM DUAL;   
 COLUMN X NEW_VALUE Z  
 SELECT lower(USERNAME) X FROM USER_USERS;  
 COLUMN X NEW_VALUE W  
 SELECT TO_CHAR(SYSDATE,'DDMMYY_hh24miss') X FROM DUAL;  
 set termout on  
  
 spool logs\instala_:Z._:Y..log  
 set define on  

prompt 01_Borrado_tablas_MIG_TMP_HIS_INT.sql ******************************************************************* 
@@01_Borrado_tablas_MIG_TMP_HIS_INT.sql

prompt 02_limpieza_cempres.sql ******************************************************************* 
@@02_limpieza_cempres.sql

prompt 03_borrado_tablas_general.sql ******************************************************************* 
@@03_borrado_tablas_general.sql

prompt 04_ini_secuencias.sql ******************************************************************* 
@@04_ini_secuencias.sql

prompt 05_revision_tablas_sseguro_con_filas.sql ******************************************************************* 
@@05_revision_tablas_sseguro_con_filas.sql

prompt 06_revision_tablas_con_filas.sql ******************************************************************* 
@@06_revision_tablas_con_filas.sql

commit; 
 

spool off