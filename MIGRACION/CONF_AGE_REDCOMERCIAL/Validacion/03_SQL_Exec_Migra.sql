/* Formatted on 27/06/2012 11:36 (Formatter Plus v4.8.8) - (CSI-Factory Standard Format v.2.0) */
/*
03 Excecuta proceso: Proceso Migra per_agr_marcas
*/
DECLARE
   --
   vncarga           mig_cargas.ncarga%TYPE := '';
   vlinea            VARCHAR2(2000);
   v_agente_padre    NUMBER := 19000; -- agente raiz 
   v_agente_pervisio NUMBER := 19000; -- agente vision personas por defecto si no viene informado
   vdummy            NUMBER;
   b_error           BOOLEAN;
   b_hay_personas    BOOLEAN;
   --
BEGIN
  --
  SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD'))
    INTO vdummy
    FROM dual;
  --
  b_error        := FALSE;
  b_hay_personas := FALSE;
  --
  dbms_output.put_line('El ncarga es :' || vncarga);
   --
   pac_mig_axis.p_migra_cargas('MIGRA_CONF', 'C', vncarga);
   --
   FOR l_reg IN (SELECT p.* 
                   FROM mig_personas p, mig_per_agr_marcas_conf pam
                  WHERE p.ncarga = vncarga
                    AND NVL(p.idperson, 0) != 0
                    AND p.mig_pk = pam.mig_fk)
   LOOP
     --
     b_hay_personas := TRUE;
     --Se debe cargar después, porq el sperson no existe a este punto
     -- Cargamos marcas de [mig_per_agr_marcas_conf] solo para personas a cargar
     BEGIN
       --
       INSERT INTO per_agr_marcas(CEMPRES, SPERSON, CMARCA, NMOVIMI,
                                  CTIPO, CTOMADOR, CCONSORCIO, CASEGURADO,
                                  CCODEUDOR, CBENEF, CACCIONISTA, CINTERMED,
                                  CREPRESEN, CAPODERADO, CPAGADOR, OBSERVACION,
                                  CUSER, FALTA)
       SELECT 24 CEMPRES, l_reg.idperson SPERSON, LPAD(pam.cmarca,4,'0'), pam.nmovimi,
             pam.CTIPO, pam.CTOMADOR, pam.CCONSORCIO, pam.CASEGURADO,
             pam.CCODEUDOR, pam.CBENEF, pam.CACCIONISTA, pam.CINTERMED,
             pam.CREPRESEN, pam.CAPODERADO, pam.CPAGADOR, pam.tobseva OBSERVACION,
             f_user CUSER, TRUNC(SYSDATE) FALTA
         FROM /*transformacion.*/mig_per_agr_marcas_conf pam
        WHERE 1 = 1
          --AND MIG_FK IN ('A0243127', 'A0555140', 'A0543803', 'A0077138');
          AND MIG_FK = l_reg.MIG_PK; 
       --
       v_mar_tot := v_mar_tot + SQL%ROWCOUNT;
       --
       --dbms_output.put_line('l_reg.MIG_PK:'||l_reg.MIG_PK||', l_reg.idperson:'||l_reg.idperson||', l_reg.nnumide:'||l_reg.nnumide||', Insert:'||SQL%ROWCOUNT||', v_mar_tot:'||v_mar_tot||', SQL%ROWCOUNT:'||SQL%ROWCOUNT);
       --
     EXCEPTION
     WHEN OTHERS THEN
       --
       dbms_output.put_line('per_agr_marcas ['||l_reg.MIG_PK|| ', ' ||l_reg.CTIPIDE||', '|| l_reg.NNUMIDE ||'] - ERR:'||SQLERRM);
       b_error := TRUE;
     END;
     --
   END LOOP;
   --
   dbms_output.put_line('Personas:'||v_per_tot||', Direcciones:'||v_dir_tot||', per_agr_marcas:'||v_mar_tot||', Personas_Rel:'||v_rel_tot||', y mig_regimenfiscal:'||v_reg_tot||', Agentes:'||v_age_tot);
   --
   IF b_hay_personas
   THEN
     --
     COMMIT;
     dbms_output.put_line('*COMMIT*');
     --
   END IF;
   -----------------------------------------
   --fin del script
   -----------------------------------------
END;
