DECLARE
    /******************************************************************************
    NOMBRE:       05_Mig_Agentes_v01
    PROPÓSITO:    Procedimiento que ejecuta carga de AGENTES - PRODUCCION

    REVISIONES:
    Ver        Fecha        Autor             Descripción
    ---------  ----------  ---------------  ------------------------------------
    1.0        ??/??/????  CXHGOME            1. Creación del script.
/* Formatted on 22/01/2017 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
Proceso para generar el proceso PL-SQL para migrar Agentes
*/
   --
   --l_data            ARRAY;
   l_timestart       NUMBER;
   l_timeend         NUMBER;
   l_time            NUMBER;
   vdummy            NUMBER;
   --
   b_hay_personas    BOOLEAN;
   vncarga           mig_cargas.ncarga%TYPE := 17410;
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   b_error           BOOLEAN;
   b_hay_dato        BOOLEAN;
   --v_cant            NUMBER := 0;   
   --
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   l_errors  NUMBER;
   l_errno   NUMBER;
   l_msg     VARCHAR2(4000);
   l_idx     NUMBER;
   --
BEGIN
  --
  l_timestart := dbms_utility.get_time(); 
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
  --
  b_error    := FALSE;
  b_hay_dato := FALSE;
  --
  -----------------------------------------
  --AGENTES
  -----------------------------------------
     FOR l_per IN ( SELECT a.* --mpc.mig_pk, count(*)
                     FROM mig_personas_cl2 mpc, mig_agentes_cl2 a
                    WHERE 1 = 1
                      AND mpc.mig_pk = a.mig_fk
                      AND a.mig_pk = 'A0713015'
                      AND  (    ctipide  IS NOT NULL
                            AND cestper  IS NOT NULL
                            AND cpertip  IS NOT NULL
                            AND swpubli  IS NOT NULL
                            AND tapelli1 IS NOT NULL
                           )
                      AND mpc.mig_pk NOT IN (SELECT DISTINCT mp.mig_pk --, COUNT(*) --Se excuyen Agentes ya existentes
                                           FROM mig_personas_cl2 mp, per_personas p, agentes a
                                          WHERE 1 = 1
                                            AND a.sperson  = p.sperson
                                            AND mp.nnumide = p.nnumide
                                            AND mp.ctipide = p.ctipide
                                            AND  (    mp.ctipide  IS NOT NULL
                                                  AND mp.cestper  IS NOT NULL
                                                  AND mp.cpertip  IS NOT NULL
                                                  AND mp.swpubli  IS NOT NULL
                                                  AND mp.tapelli1 IS NOT NULL
                                                 )
                                            AND (SELECT COUNT(pp.sperson)
                                                   FROM per_personas pp, agentes ag
                                                  WHERE pp.nnumide = mp.nnumide
                                                    AND pp.ctipide = mp.ctipide
                                                    AND pp.sperson = ag.sperson) > 0
                                                    --GROUP BY  mp.mig_pk HAVING COUNT(*) > 0
                                              ) --Recibir instruccion, para borrar personas ya creadas
                  --GROUP BY mpc.mig_pk HAVING COUNT(*) > 0
                  ORDER BY mpc.CTIPIDE, mpc.NNUMIDE
                  )
     LOOP
       --
       b_hay_personas := TRUE;
       b_hay_dato     := TRUE;
       --
       BEGIN
         --
         BEGIN
           --
           INSERT INTO mig_agentes(ncarga, cestmig, mig_pk, mig_fk, cagente, idperson, ctipage, cactivo,
                           cretenc, ctipiva, ccomisi, cpadre, fmovini, fmovfin, cpervisio,
                           cpernivel, cpolvisio, cpolnivel, finivig)
          VALUES(vncarga,
                 1,
                 l_per.mig_pk,
                 l_per.mig_fk,
                 f_set_agente(24, l_per.ctipage) ,
                 0 , --idperson
                 l_per.ctipage, -- nvl(ctipage,5),
                 --ojo con esto la aspecifiación es incorrecta 0 activo 1- inactivo, cuando es al reves
                 l_per.cactivo,
                 l_per.cretenc,
                 l_per.ctipiva,
                 to_number(REPLACE(REPLACE(REPLACE(l_per.ccomisi, 'GC', ''),
                                           '#N/A',
                                           1),
                                   'GR',
                                   '')) ,
                 l_per.cpadre,
                 NVL(l_per.fmovini, f_sysdate),
                 l_per.fmovfin,
                 v_agente_pervisio,
                 DECODE(l_per.cpernivel, 0, 1, l_per.cpernivel),
                 v_agente_pervisio,
                 DECODE(l_per.cpolnivel, 0, 1, l_per.cpolnivel) , --cpolnivel
                 l_per.fmovini);
           --
           dbms_output.put_line('- Inserta  - '||SQL%ROWCOUNT);
           --
         EXCEPTION
         WHEN OTHERS THEN
           --
           p_control_error('CXHGOME','05_Mig_Agentes', 'l_per.mig_pk: '||l_per.mig_pk||' ERR:'||SQLERRM);
           dbms_output.put_line('l_per.mig_pk: '||l_per.mig_pk||' ERR:'||SQLERRM);
           b_error := TRUE;
           --
         END;
         --
         /*v_cant := v_cant + 1;
         --
         IF MOD(v_cant,20)= 0
         THEN
           --
           p_control_error('CXHGOME','04_Mig_Agentes','v_cant:'||v_cant);
           --
         END IF;*/
         --
       EXCEPTION
       WHEN OTHERS THEN
         --
         dbms_output.put_line('LOOP PERSONAS [' ||l_per.MIG_PK||', '|| l_per.MIG_FK ||'] - ERR:'||SQLERRM);
         b_error := TRUE;
         --
       END;
       --
     END LOOP;
   --
   IF NOT b_error 
      AND b_hay_dato
   THEN
    --
    COMMIT;
    dbms_output.put_line('- COMMIT -');
    --
   ELSE
    --
    ROLLBACK;
    dbms_output.put_line('- ROLLBACK -');
    --
   END IF;
   --
   l_timeend := dbms_utility.get_time(); 
   l_time    := (l_timeend - l_timestart) / 100;
   dbms_output.put_line('Tiempo de Ejecución: ' || l_time || ' seg'); 
   --
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
--
SELECT * FROM mig_agentes WHERE ncarga = 17410;
SELECT * FROM control_error WHERE TRUNC(fecha)= TRUNC(SYSDATE) AND donde = '05_Mig_Agentes';
--
SELECT * FROM AGENTES s WHERE 1 = 1 AND cagente = 487;     
