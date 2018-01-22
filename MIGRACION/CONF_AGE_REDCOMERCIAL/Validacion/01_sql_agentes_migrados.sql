SELECT * FROM mig_agentes where cagente is null;
select * from all_tables where owner = 'TRANSFORMACION' and table_name like '%_CONF';
--
--select * from transformacion.MIG_AGENTES_CONF where mig_pk = ;
--
-- pac_redcomercial.ff_desagente
--
select m.mig_pk, p.nnumide, m.cagente, a.sperson, a.cdomici,
pac_redcomercial.ff_desagente(m.cagente, 8) cagente, 
pac_redcomercial.ff_desagente(r.cpadre , 8) sucursal--,
--d.cprovin, pr.tprovin provincia,
--d.cpoblac, pac_isqlfor.f_pobagente(m.cagente, d.cdomici) poblacion, 
--d.sperson, 
--d.cdomici, d.tnomvia
from mig_agentes m, agentes a, per_personas p, redcomercial r , per_direcciones d , provincias pr
where 1 = 1 
AND r.cempres = 24
and m.cagente = 4000001
--and p.nnumide = '79246286'
/*and mig_pk in ('8605109951',
'900185572','9000795805','8070030785','9002501607',
'8605079065','1022399710','1013639973','1033726918',
'1095786439','1070919868','1053765650','1085245486',
'1053777579','1052389864','1020724346','1095786356','1118534391','1013610751')*/
and p.sperson = a.sperson
--and m.mig_fk = d.mig_pk
and a.sperson = d.sperson
--and a.cagente = d.cagente
and a.cagente = m.cagente
and a.cagente = r.cagente --(+)
and pr.cprovin = d.cprovin
--and d.cprovin  = 
order by m.cagente;
--and pd.sperson = m.idperson;
--
-- INFO CON 
select m.mig_pk, p.nnumide, m.cagente, a.sperson, a.cdomici,
pac_redcomercial.ff_desagente(m.cagente, 8) cagente, 
pac_redcomercial.ff_desagente(r.cpadre , 8) sucursal,
d.cprovin, pr.tprovin provincia,
d.cpoblac, pac_isqlfor.f_pobagente(m.cagente, d.cdomici) poblacion, 
--d.sperson, 
d.cdomici, 
d.tnomvia
from mig_agentes m, agentes a, per_personas p, redcomercial r, mig_direcciones d, provincias pr
where 1 = 1 
AND r.cempres = 24
--and m.cagente = 4000001
--and p.nnumide = '79246286'
/*and mig_pk in ('8605109951',
'900185572','9000795805','8070030785','9002501607',
'8605079065','1022399710','1013639973','1033726918',
'1095786439','1070919868','1053765650','1085245486',
'1053777579','1052389864','1020724346','1095786356','1118534391','1013610751')*/
and p.sperson = a.sperson
and m.mig_fk = d.mig_pk
--and a.sperson = d.sperson
--and a.cagente = d.cagente
and a.cagente = m.cagente
and a.cagente = r.cagente (+)
and pr.cprovin = d.cprovin
order by m.cagente;
--
SELECT * FROM redcomercial s WHERE s =  ORDER BY s ;    
--
 SELECT * from agentes where sperson = 1497;
  SELECT * from agentes_comp where cagente = 4000001;
    SELECT * from agentesCO where cagente = 4000001;
 SELECT * from per_direcciones where sperson = 1497;
 SELECT * FROM comisionvig_agente s WHERE s.cagente = 4000001;

--
SELECT * FROM per_direcciones s; --WHERE s =  ORDER BY s ;  
SELECT * FROM provincias  s WHERE s.cprovin in (8, 76);
select * from AGENTES where cagente IN (6000961, 20112);
SELECT * FROM per_detper s WHERE s.sperson = 201603001;
SELECT * FROM mig_direcciones s WHERE s.mig_pk = '900696325-05'
SELECT * FROM direcciones s WHERE s.mig_pk = '900696325-05'

select * from redcomercial where cagente = 6000961;
select * from segurosredcom  where cagente = 6000952;
select * from ageredcom where cagente = 6000952;
--
SELECT F_DESPROVIN( FROM dual s WHERE s =  ORDER BY s ;   
select * from CTATECNICA; -- Contratos Automàticos
select * from mig_cargas_tab_mig;
select * from reasegemi;
select * from CESIONESREA;
select * from det_CESIONESREA;
-- 
select * from CUAFACUL;
select * from CUACESFAC;
--
select * from all_tables where table_name like '%INDIC%';
select * from all_tab_columns where column_name like '%NCERTDIAN%';
SELECT * FROM TIPOS_INDICADORES s;
SELECT * FROM TIPOS_INDICADORES_DET s;
SELECT * FROM recibos s WHERE s =  ORDER BY s ;  
SELECT * FROM movrecibo s;
--
select * from rango_dian;
select * from rango_dian_movseguro;
--
SELECT * FROM transformacion.MIG_TIPOS_INDICADORES_CONF s WHERE s =  ORDER BY s ;  
--
Pac_Mig_Axis
--
SELECT * FROM all_source s where s.owner = 'AXIS' AND upper(s.text) LIKE UPPER('%rango_dian_movseguro%');  
PAC_MD_REDCOMERCIAL;
PAC_IAX_PERSONA;
PAC_ISQLFOR;
F_DESPROVIN;
pac_mig_axis
--
SELECT * FROM transformacion.mig_agentes_conf where cagente is null;
SELECT * FROM mig_personas;
SELECT * FROM mig_agentes_conf where cagente is not null;
SELECT * FROM mig_cargas_tab_mig;
--
pac_mig_axis.p_borra_cargas;
--
SELECT * FROM mig_logs_axis where ncarga = 17382;
SELECT * FROM transformacion.mig_personas_conf s WHERE s.mig_pk = '900930211';
SELECT * FROM transformacion.mig_agentes_conf s WHERE s.mig_fk = '900930211';
--
