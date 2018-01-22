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
     SELECT SNIP, CTIPIDE, NNUMIDE, mpc.tnombre, mpc.tapelli1
       FROM /*transformacion.*/mig_personas_conf mpc
      WHERE 1 = 1
        --AND mpc.nnumide IS NOT NULL
/*        AND NOT EXISTS (SELECT '' FROM per_personas
                                 WHERE nnumide = mpc.nnumide
                                   AND ctipide = mpc.ctipide)*/
         /*AND (SELECT COUNT(1) FROM agentes a
                             WHERE a.sperson = (SELECT sperson 
                                                  FROM per_personas 
                                                 WHERE nnumide = mpc.nnumide
                                                   AND ctipide = mpc.ctipide)
              ) = 0
         */
        --AND MIG_PK IN ('A0243127', 'A0555140', 'A0543803', 'A0077138', '900930211')
        --AND mig_pk = 'A0021916'
        /*and (    ctipide is null 
              or cestper is null 
              or cpertip is null
              or cpertip is null
              or cpertip is null
              or swpubli is null
              or tapelli1 is null
             )*/
        AND  (    ctipide  IS NOT NULL 
              AND cestper  IS NOT NULL 
              AND cpertip  IS NOT NULL
              AND swpubli  IS NOT NULL
              AND tapelli1 IS NOT NULL
             )
--    GROUP BY SNIP, CTIPIDE, NNUMIDE
        AND (SELECT COUNT(sperson) 
               FROM per_personas 
              WHERE nnumide = mpc.nnumide
                AND ctipide = mpc.ctipide) > 1
    ORDER BY CTIPIDE, NNUMIDE;
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
   TYPE t_mig_personas IS TABLE OF lc_mig_personas_1%ROWTYPE;
   l_per t_mig_personas;
   --
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   l_errors  NUMBER;
   l_errno   NUMBER;
   l_msg     VARCHAR2(4000);
   l_idx     NUMBER;
   --
   PROCEDURE pi_borra_persona(p_ctipide NUMBER, p_nnumide VARCHAR2) IS
     --
     v_sperson  per_personas.sperson%TYPE;
     --
   BEGIN
      --
      SELECT sperson INTO v_sperson
        FROM per_personas s
       WHERE s.ctipide = p_ctipide AND s.nnumide = p_nnumide;
      --
      dbms_output.put_line('Borro sperson:'||v_sperson);   
      DELETE FROM PER_IDENTIFICADOR WHERE sperson = v_sperson;
      DELETE FROM PER_DIRECCIONES WHERE sperson = v_sperson;
      DELETE FROM PER_PERSONAS_REL WHERE sperson = v_sperson;
      DELETE FROM PER_CONTACTOS WHERE sperson = v_sperson;
      DELETE FROM PER_DETPER WHERE sperson = v_sperson;
      DELETE FROM PER_REGIMENFISCAL WHERE sperson = v_sperson;
      DELETE FROM PER_CCC WHERE sperson = v_sperson;
      DELETE FROM PER_PERSONAS WHERE sperson = v_sperson;
      DELETE FROM AGENTES WHERE sperson = v_sperson; 
      --
      v_cant := v_cant + 1;
      --
      --dbms_output.put_line('Borro sperson:'||v_sperson);   
      --
      --
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      --
      NULL;
      --
   END pi_borra_persona;
   --
BEGIN
  --
   -----------------------------------------
   --BORRO PERSONAS
   -----------------------------------------
   --
   /*FOR l_per IN lc_mig_personas
   LOOP
     --
     b_hay_personas := TRUE;
     --
     BEGIN
       --
       pi_borra_persona(p_ctipide => l_per.ctipide, p_nnumide => l_per.nnumide);
       --
     EXCEPTION
     WHEN OTHERS THEN
       --
       dbms_output.put_line('LOOP PERSONAS [' ||l_per.CTIPIDE||', '|| l_per.NNUMIDE ||'] - ERR:'||SQLERRM);
       b_error := TRUE;
       --
     END;  
     --
   END LOOP;*/
   --
      --PERSONAS
   -----------------------------------------
   --
  OPEN lc_mig_personas_1;
  LOOP
    --
    FETCH lc_mig_personas_1 BULK COLLECT INTO l_per LIMIT 10000;  -- limit to 10k to avoid out of memory
    --
      FORALL i IN 1..l_per.COUNT ----SAVE EXCEPTIONS      
      DELETE FROM PER_IDENTIFICADOR WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_DIRECCIONES WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_PERSONAS_REL WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_CONTACTOS WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_NACIONALIDADES WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_DETPER WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_REGIMENFISCAL WHERE sperson = l_per(i).idperson;
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_CCC WHERE sperson = l_per(i).idperson;
      
      /*FORALL i IN 1..l_per.COUNT ----SAVE EXCEPTIONS      
      DELETE FROM AGENTES WHERE sperson = l_per(i).idperson;*/
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM PER_PERSONAS WHERE sperson = l_per(i).idperson;            
      
      FORALL i IN 1..l_per.COUNT --SAVE EXCEPTIONS      
      DELETE FROM mig_personas WHERE idperson = l_per(i).idperson;      
    --
    --
   EXIT WHEN lc_mig_personas_1%NOTFOUND;
   --
  END LOOP;
   --
   CLOSE lc_mig_personas_1;
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
