/* Formatted on 27/06/2012 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para borrar personas el proceso PL-SQL para migrar las Personas, Direcciones, per_agr_marcas, Personas_Rel y mig_regimenfiscal
*/
DECLARE
   --
   b_error           BOOLEAN := FALSE;
   b_hay_personas    BOOLEAN;
   v_cant            NUMBER := 0;
   --
    CURSOR lc_mig_personas IS
     SELECT d.sperson idperson FROM Per_Detper d WHERE d.sperson IN (2, 4, 5, 6, 7, 8, 9, 10);
    --
    CURSOR lc_mig_personas_1 IS
      SELECT p1.ctipide, p1.nnumide, p1.idperson FROM mig_personas p1
      WHERE (p1.ctipide, p1.nnumide) IN (
      select p.ctipide, p.nnumide
        from mig_personas p --, mig_
       where p.ncarga = 17411 --AND p.cestmig = -9
      GROUP BY p.ctipide, p.nnumide
      HAVING COUNT(*) > 1)
      AND p1.idperson IN ( SELECT p0.idperson
                            FROM mig_personas      p0, 
                                 mig_personas_conf c0
                          WHERE p0.ctipide = c0.ctipide
                            AND p0.nnumide = c0.nnumide
                            AND p0.ncarga  = 17411
                            AND p0.idperson != 0
                            --AND p0.nnumide = '100683'
                            AND p0.mig_pk <> c0.snip)
      AND p1.idperson NOT IN (SELECT p0.idperson
                            FROM mig_personas      p0, 
                                 mig_personas_conf c0
                          WHERE p0.ctipide = c0.ctipide
                            AND p0.nnumide = c0.nnumide
                            AND p0.ncarga  = 17411
                            AND p0.idperson != 0
                            --AND p0.nnumide = '79979810'
                            AND p0.mig_pk = c0.snip)
      GROUP BY p1.ctipide, p1.nnumide, p1.idperson;
   --
   TYPE t_mig_personas IS TABLE OF lc_mig_personas%ROWTYPE;
   l_per t_mig_personas;
   --
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   l_errors  NUMBER;
   l_errno   NUMBER;
   l_msg     VARCHAR2(4000);
   l_idx     NUMBER;
   --
   PROCEDURE pi_bulk_log (p_tabla VARCHAR2) IS
     --
   BEGIN
      --
      l_errors := SQL%bulk_exceptions.count;
      --
      dbms_output.put_line(p_tabla ||' errors: ['||l_errors||']');
      --
      FOR i IN 1 .. l_errors
      LOOP
        --
        l_errno := SQL%BULK_EXCEPTIONS(i).error_code;
        l_msg   := SQLERRM(-l_errno);
        l_idx   := SQL%BULK_EXCEPTIONS(i).error_index;
        --
        p_control_error(f_user, p_tabla, '['||l_idx||']: '||l_errno||' - '||l_msg||'. PK: '||l_per(l_idx).idperson);
        --
      END LOOP;
      --
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --
      NULL;
      --
   END pi_bulk_log;
   --
BEGIN
  --
   -----------------------------------------
   --BORRO PERSONAS
   -----------------------------------------
   --
  OPEN lc_mig_personas;
  LOOP
    --
    FETCH lc_mig_personas BULK COLLECT INTO l_per LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
      BEGIN
        --
        FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS
        DELETE FROM PER_IDENTIFICADOR WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_IDENTIFICADOR');
        --
      END;
      --
      BEGIN
        --
        FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
        DELETE FROM PER_DIRECCIONES WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_DIRECCIONES');
        --
      END;
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_PERSONAS_REL WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_PERSONAS_REL');
        --
      END;
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_CONTACTOS WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_CONTACTOS');
        --
      END;
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_NACIONALIDADES WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_NACIONALIDADES');
        --
      END;

      BEGIN
        --
        FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
        DELETE FROM PER_DETPER WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_DETPER');
        --
      END;
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_REGIMENFISCAL WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_REGIMENFISCAL');
        --
      END;
      --
      BEGIN
        --      
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_CCC WHERE sperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_CCC');
        --
      END;
      
      /*FORALL i IN 1..l_per.COUNT ----SAVE EXCEPTIONS      
      DELETE FROM AGENTES WHERE sperson = l_per(i).idperson;--no borrar agentes*/
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM PER_PERSONAS WHERE sperson = l_per(i).idperson;            
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'PER_PERSONAS');
        --
      END;
      --
      BEGIN
        --
      FORALL i IN 1..l_per.COUNT SAVE EXCEPTIONS      
      DELETE FROM mig_personas WHERE idperson = l_per(i).idperson;
        --      
      EXCEPTION
      WHEN DML_ERRORS THEN
        --
        pi_bulk_log(p_tabla => 'MIG_PERSONAS');
        --
      END;
    --
    --
   EXIT WHEN lc_mig_personas%NOTFOUND;
   --
  END LOOP;
   --
   CLOSE lc_mig_personas;
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
select * from per_personas where sperson in (
SELECT idperson FROM mig_personas s WHERE s.ncarga = 17411);                                
--
SELECT * FROM user_constraints s WHERE s.CONSTRAINT_NAME = 'PER_NACIONALI_PER_DETPER_FK';
SELECT * FROM mig_agentes s WHERE s.idperson != 0;
SELECT * FROM PER_NACIONALIDADES s WHERE s =  ORDER BY s ;     
SELECT * FROM agentes s WHERE s.sperson = 19991;               
SELECT * FROM CONTRATOSAGE s WHERE s.cagente = 3;
SELECT * FROM control_error s WHERE trunc(s.fecha) = trunc(sysdate) and id = 'CXHGOME' and seqerror > 9635702;
SELECT * FROM control_error s WHERE s.donde = 'PER_DETPER';
SELECT * FROM mig_personas s WHERE s.mig_pk IN('34564848', '4161052', '79108845', '98660103', '9866028', '811014973', '830029471', '900749554');
[6650]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 34564848
[6313]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 4161052
[968]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 79108845
[354]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 98660103
[3259]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 9866028
[549]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 811014973
[5681]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 830029471
[1710]: 2292 - ORA-02292: restricción de integridad (.) violada - registro secundario encontrado.. PK: 900749554
--
SELECT * FROM mig_personas s WHERE s.idperson != 0 and s.ncarga !=17411 and not exists (SELECT '' FROM per_identificador i WHERE i.sperson=s.idperson);
SELECT * FROM per_identificador s WHERE s.sperson IN (1048, 327); pac_mig_axis
--SELECT * FROM PER_DIRECCIONES s WHERE s.sperson in (SELECT idperson FROM mig_personas s WHERE s.idperson !=0);
SELECT * FROM per_personas s WHERE s.nnumide='79979810'; --242409
SELECT * FROM mig_personas s WHERE s.nnumide='79979810';
SELECT * FROM mig_personas_conf s WHERE s.nnumide='79979810';
--
SELECT * FROM  s WHERE s =  ORDER BY s ;
--
SELECT p.idperson
  FROM mig_personas      p, 
       mig_personas_conf c
WHERE p.ctipide = c.ctipide
  AND p.nnumide = c.nnumide
  AND p.ncarga  = 17411
  AND p.idperson != 0
  AND p.nnumide = '64556169'
  AND p.mig_pk = c.snip;
