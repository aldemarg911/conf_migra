--
-- 01_Carga_Mig_Cargas_v01.sql / Tomado de la Versión FicheroGeneralMigración_v04.xlsx
--
DELETE mig_cargas WHERE ncarga >= 17413;
--DELETE FROM mig_cargas_tab_mig WHERE ncarga >= 17413;
--
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17413, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PERSONAS_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17415, 24, f_sysdate, f_sysdate, 'OK', 'MIG_COMPANIAS_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17416, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CONTRATOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17417, 24, f_sysdate, f_sysdate, 'OK', 'MIG_TRAMOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17418, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CUADROCES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17414, 24, f_sysdate, f_sysdate, 'OK', 'MIG_TIPOS_INDICADORES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17434, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTGAR_CONTRAGARANTIA_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17419, 24, f_sysdate, f_sysdate, 'OK', 'MIG_BUREAU_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17420, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SEGUROS_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17422, 24, f_sysdate, f_sysdate, 'OK', 'MIG_ASEGURADOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17423, 24, f_sysdate, f_sysdate, 'OK', 'MIG_MOVSEGURO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17424, 24, f_sysdate, f_sysdate, 'OK', 'MIG_RIESGOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17425, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SITRIESGO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17426, 24, f_sysdate, f_sysdate, 'OK', 'MIG_GARANSEG_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17427, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CLAUSUESP_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17428, 24, f_sysdate, f_sysdate, 'OK', 'MIG_BENESPSEG_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17429, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PREGUNSEG_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17430, 24, f_sysdate, f_sysdate, 'OK', 'MIG_COMISIONSEGU_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17431, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTASEGURO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17432, 24, f_sysdate, f_sysdate, 'OK', 'MIG_AGENSEGU_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17433, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PREGUNGARANSEG_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17435, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTGAR_SEGURO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17436, 24, f_sysdate, f_sysdate, 'OK', 'MIG_AGE_CORRETAJE_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17437, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PSU_RETENIDAS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17438, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_PROF_PROFESIONALES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17439, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_PROF_INDICADORES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17440, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_SINIESTRO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17441, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_MOVSINIESTRO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17442, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITACION_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17443, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_MOVIMIENTO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17444, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_RESERVA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17445, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_PAGO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17446, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_MOVPAGO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17447, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_PAGO_GAR_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17448, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_JUDICIAL_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17449, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAM_JUDI_DETPER_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17450, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAM_VALPRET_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17451, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_FISCAL_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17452, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAM_VPRETFIS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17453, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_CITACIONES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17454, 24, f_sysdate, f_sysdate, 'OK', 'MIG_AGD_OBSERVACIONES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17455, 24, f_sysdate, f_sysdate, 'OK', 'MIG_SIN_TRAMITA_APOYO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17456, 24, f_sysdate, f_sysdate, 'OK', 'MIG_RECIBOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17457, 24, f_sysdate, f_sysdate, 'OK', 'MIG_MOVRECIBO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17458, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETRECIBOS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17459, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETMOVRECIBO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17460, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETMOVRECIBO_PARCIAL_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17461, 24, f_sysdate, f_sysdate, 'OK', 'MIG_LIQUIDACAB_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17462, 24, f_sysdate, f_sysdate, 'OK', 'MIG_LIQUIDALIN_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17463, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTACTES_TXT'); 



   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17464, 24, f_sysdate, f_sysdate, 'OK', 'PTPPLP_TXT'); 


   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17465, 24, f_sysdate, f_sysdate, 'OK', 'PPNA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17466, 24, f_sysdate, f_sysdate, 'OK', 'PRPC_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17467, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CLAUSULAS_REAS_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17468, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTATECNICA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17469, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CESIONESREA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17470, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DET_CESIONESREA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17471, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CUAFACUL_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17472, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CUACESFAC_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17473, 24, f_sysdate, f_sysdate, 'OK', 'MIG_ECO_TIPOCAMBIO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17474, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTAPB_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17475, 24, f_sysdate, f_sysdate, 'OK', 'MIG_PLANILLAS_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17476, 24, f_sysdate, f_sysdate, 'OK', 'MIG_FIN_GENERAL_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17477, 24, f_sysdate, f_sysdate, 'OK', 'MIG_FIN_D_RENTA_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17478, 24, f_sysdate, f_sysdate, 'OK', 'MIG_FIN_ENDEUDAMIENTO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17479, 24, f_sysdate, f_sysdate, 'OK', 'MIG_FIN_INDICADORES_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17480, 24, f_sysdate, f_sysdate, 'OK', 'MIG_FIN_PARINDICADORES_TXT'); 

   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17481, 24, f_sysdate, f_sysdate, 'OK', 'MIG_COACUADRO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17482, 24, f_sysdate, f_sysdate, 'OK', 'MIG_COACEDIDO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17483, 24, f_sysdate, f_sysdate, 'OK', 'MIG_CTACOASEGURO_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17484, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DATSARLAFT_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17485, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETSARLATF_ACT_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17486, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETSARLAFT_REC_TXT'); 
   INSERT INTO mig_cargas
      (ncarga, cempres, finiorg, ffinorg, estorg, id)
   VALUES
      (17487, 24, f_sysdate, f_sysdate, 'OK', 'MIG_DETSARLATF_DEC_TXT'); 
--
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 1, 'Inserts Directos', 'MIG_PERSONAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 2, 'Inserts Directos', 'MIG_DIRECCIONES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 3, 'Inserts Directos', 'MIG_PERSONAS_REL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 4, 'Inserts Directos', 'MIG_REGIMENFISCAL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 92, 'Inserts Directos', 'MIG_PARPERSONAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 5, 'Inserts Directos', 'MIG_AGENTES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17413, 6, 'Inserts Directos', 'MIG_PER_AGR_MARCAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17415, 7, 'Inserts Directos', 'MIG_COMPANIAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17415, 8, 'Inserts Directos', 'MIG_CODICONTRATOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17415, 9, 'Inserts Directos', 'MIG_AGR_CONTRATOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17416, 10, 'Inserts Directos', 'MIG_CONTRATOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17417, 11, 'Inserts Directos', 'MIG_TRAMOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17418, 12, 'Inserts Directos', 'MIG_CUADROCES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17414, 13, 'Inserts Directos', 'MIG_TIPOS_INDICADORES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17434, 29, 'Inserts Directos', 'MIG_CTGAR_CONTRAGARANTIA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17434, 30, 'Inserts Directos', 'MIG_CTGAR_DET');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17434, 31, 'Inserts Directos', 'MIG_CTGAR_INMUEBLE');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17434, 32, 'Inserts Directos', 'MIG_CTGAR_VEHICULO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17434, 33, 'Inserts Directos', 'MIG_CTGAR_CODEUDOR');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17419, 14, 'Inserts Directos', 'MIG_BUREAU');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17420, 15, 'Inserts Directos', 'MIG_SEGUROS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17420, 16, 'Inserts Directos', 'MIG_HISTORICOSEGUROS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17422, 17, 'Inserts Directos', 'MIG_ASEGURADOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17423, 18, 'Inserts Directos', 'MIG_MOVSEGURO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17424, 19, 'Inserts Directos', 'MIG_RIESGOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17425, 20, 'Inserts Directos', 'MIG_SITRIESGO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17426, 21, 'Inserts Directos', 'MIG_GARANSEG');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17427, 22, 'Inserts Directos', 'MIG_CLAUSUESP');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17428, 23, 'Inserts Directos', 'MIG_BENESPSEG');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17429, 24, 'Inserts Directos', 'MIG_PREGUNSEG');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17430, 25, 'Inserts Directos', 'MIG_COMISIONSEGU');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17431, 26, 'Inserts Directos', 'MIG_CTASEGURO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17432, 27, 'Inserts Directos', 'MIG_AGENSEGU');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17433, 28, 'Inserts Directos', 'MIG_PREGUNGARANSEG');


   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17435, 34, 'Inserts Directos', 'MIG_CTGAR_SEGURO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17436, 35, 'Inserts Directos', 'MIG_AGE_CORRETAJE');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17437, 36, 'Inserts Directos', 'MIG_PSU_RETENIDAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17438, 37, 'Inserts Directos', 'MIG_SIN_PROF_PROFESIONALES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17439, 38, 'Inserts Directos', 'MIG_SIN_PROF_INDICADORES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17440, 39, 'Inserts Directos', 'MIG_SIN_SINIESTRO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17441, 40, 'Inserts Directos', 'MIG_SIN_MOVSINIESTRO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17442, 41, 'Inserts Directos', 'MIG_SIN_TRAMITACION');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17443, 42, 'Inserts Directos', 'MIG_SIN_TRAMITA_MOVIMIENTO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17444, 43, 'Inserts Directos', 'MIG_SIN_TRAMITA_RESERVA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17445, 44, 'Inserts Directos', 'MIG_SIN_TRAMITA_PAGO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17446, 45, 'Inserts Directos', 'MIG_SIN_TRAMITA_MOVPAGO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17447, 46, 'Inserts Directos', 'MIG_SIN_TRAMITA_PAGO_GAR');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17448, 47, 'Inserts Directos', 'MIG_SIN_TRAMITA_JUDICIAL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17449, 48, 'Inserts Directos', 'MIG_SIN_TRAM_JUDI_DETPER');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17450, 49, 'Inserts Directos', 'MIG_SIN_TRAM_VALPRET');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17451, 50, 'Inserts Directos', 'MIG_SIN_TRAMITA_FISCAL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17452, 51, 'Inserts Directos', 'MIG_SIN_TRAM_VPRETFIS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17453, 52, 'Inserts Directos', 'MIG_SIN_TRAMITA_CITACIONES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17454, 53, 'Inserts Directos', 'MIG_AGD_OBSERVACIONES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17455, 54, 'Inserts Directos', 'MIG_SIN_TRAMITA_APOYO');

   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17456, 55, 'Inserts Directos', 'MIG_RECIBOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17457, 56, 'Inserts Directos', 'MIG_MOVRECIBO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17458, 57, 'Inserts Directos', 'MIG_DETRECIBOS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17459, 58, 'Inserts Directos', 'MIG_DETMOVRECIBO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17460, 59, 'Inserts Directos', 'MIG_DETMOVRECIBO_PARCIAL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17461, 60, 'Inserts Directos', 'MIG_LIQUIDACAB');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17462, 61, 'Inserts Directos', 'MIG_LIQUIDALIN');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17463, 62, 'Inserts Directos', 'MIG_CTACTES');



   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17464, 66, 'Inserts Directos', 'PTPPLP');


   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17465, 69, 'Inserts Directos', 'PPNA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17466, 70, 'Inserts Directos', 'PRPC');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17467, 71, 'Inserts Directos', 'MIG_CLAUSULAS_REAS');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17468, 72, 'Inserts Directos', 'MIG_CTATECNICA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17469, 73, 'Inserts Directos', 'MIG_CESIONESREA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17470, 74, 'Inserts Directos', 'MIG_DET_CESIONESREA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17471, 75, 'Inserts Directos', 'MIG_CUAFACUL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17472, 76, 'Inserts Directos', 'MIG_CUACESFAC');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17473, 77, 'Inserts Directos', 'MIG_ECO_TIPOCAMBIO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17474, 78, 'Inserts Directos', 'MIG_CTAPB');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17475, 79, 'Inserts Directos', 'MIG_PLANILLAS');

   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17476, 80, 'Inserts Directos', 'MIG_FIN_GENERAL');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17477, 81, 'Inserts Directos', 'MIG_FIN_D_RENTA');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17478, 82, 'Inserts Directos', 'MIG_FIN_ENDEUDAMIENTO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17479, 83, 'Inserts Directos', 'MIG_FIN_INDICADORES');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17480, 84, 'Inserts Directos', 'MIG_FIN_PARINDICADORES');

   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17481, 85, 'Inserts Directos', 'MIG_COACUADRO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17482, 86, 'Inserts Directos', 'MIG_COACEDIDO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17483, 87, 'Inserts Directos', 'MIG_CTACOASEGURO');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17484, 88, 'Inserts Directos', 'MIG_DATSARLAFT');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17485, 89, 'Inserts Directos', 'MIG_DETSARLATF_ACT');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17486, 90, 'Inserts Directos', 'MIG_DETSARLAFT_REC');
   INSERT INTO mig_cargas_tab_mig
      (ncarga, ntab, tab_org, tab_des)
   VALUES
      (17487, 91, 'Inserts Directos', 'MIG_DETSARLATF_DEC');
