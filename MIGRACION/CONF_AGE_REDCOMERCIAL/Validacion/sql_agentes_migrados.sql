SELECT pac_contexto.f_inicializarctx(pac_parametros.f_parempresa_t(24, 'USER_BBDD')) FROM dual;
SELECT a.cagente codi,
       pac_redcomercial.ff_desagente(a.cagente, 8, 0) nombre,
       a.ctipage,
       r.cpadre,
       pac_redcomercial.ff_desagente(r.cpadre, 8, 0) tsucursal,
       p.nnumide,
       m.mig_pk
  FROM agentes            a,
       redcomercial       r,
       per_personas       p,
       mig_agentes        m
 WHERE a.cagente = NVL(NVL(TO_CHAR(NULL), NULL), a.cagente)
   AND r.cempres = 24
   AND a.sperson = p.sperson
   AND a.ctipage = NVL(NULL, a.ctipage)
   AND r.cagente(+) = a.cagente
   AND a.cagente = m.cagente
ORDER BY a.cagente;
--
SELECT * FROM sin_tramita_citaciones s;  
SELECT * FROM sin_tramita_judicial s ;
SELECT * FROM sin_tramita_judicial_audien s ;

SELECT * FROM sin_tramita_fiscal s ;

SELECT * FROM all_tab_columns s where owner = 'CONF_V' and column_name = 'NTRAMIT';
SELECT * FROM all_tables s where owner = 'CONF_V' and table_name like '%SIN_TRAMI%CIT%';
--
SELECT ff_desvalorfijo(8001090,8) FROM dual s WHERE s =  ORDER BY s ; 
SELECT * FROM valores s WHERE s.tvalor like '%EPOS%' and cidioma = 8;
SELECT * FROM valores s where cvalor = 8001119
SELECT * FROM detvalores s WHERE s.cvalor = 124 and cidioma = 8;

SELECT * FROM detvalores s WHERE s.tatribu like '%EPOS%' and cidioma = 8;
SELECT * FROM axis.SIN_TRAMITA_JUDICIAL s ;
SELECT * FROM axis.SIN_TRAMITA_JUDICIAL s ;
