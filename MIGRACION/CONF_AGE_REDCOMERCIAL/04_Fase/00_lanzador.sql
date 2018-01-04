define P_NUM_PATCH=Migra_Red_Comercial
 set termout off  
 set define ':' 
 COLUMN X NEW_VALUE Y  
 SELECT REPLACE(SUBSTR (SYS.DBMS_STANDARD.DATABASE_NAME, 1, CASE WHEN INSTR (SYS.DBMS_STANDARD.DATABASE_NAME, '.') = 0 THEN LENGTH (SYS.DBMS_STANDARD.DATABASE_NAME) ELSE INSTR (SYS.DBMS_STANDARD.DATABASE_NAME, '.') - 1  END),'_','') X  FROM DUAL;   
 COLUMN X NEW_VALUE Z  
 SELECT lower(USERNAME) X FROM USER_USERS;  
 COLUMN X NEW_VALUE W  
 SELECT TO_CHAR(SYSDATE,'DDMMYY_hh24miss') X FROM DUAL;  
 set termout on  

set lines 4100
set serveroutput on size 10000  
 spool logs\instala_:P_NUM_PATCH._:Z._:Y..log  
 set define on  
 
 set define off

  
prompt 01_actualiza_agentes.sql  ******************************************************************* 
@@01_actualiza_agentes.sql

prompt 03_actualiza_direcciones.sql  ******************************************************************* 
@@03_actualiza_direcciones.sql

prompt 04_actualiza_ageredcom.sql ******************************************************************* 
@@04_actualiza_ageredcom.sql

commit; 
 
spool off 
set serveroutput off 

set define on 
