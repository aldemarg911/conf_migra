SELECT a.cagente codi,
       pac_redcomercial.ff_desagente(a.cagente, 8, 0) nombre,
       a.ctipage,
       r.cpadre,
       pac_redcomercial.ff_desagente(r.cpadre, 8, 0) tsucursal,
       p.nnumide,
       c.ccomisi, c.ctipo, d.tcomisi, 
       cva.dcomisi comision_vigente
       --,cp.cramo, cp.sproduc || ' - ' || vp.ttitulo producto, cp.pcomisi
  FROM agentes            a,
       redcomercial       r,
       per_personas       p,
       codicomisio        c,
       descomision        d,
       (SELECT cva.cagente, cva.ccomisi, cva.ccomisi || ' - ' || d1.tcomisi dcomisi
          FROM comisionvig_agente cva, descomision d1
         WHERE cva.ccomisi = d1.ccomisi AND d1.cidioma = 8
           AND cva.ffinvig IS NULL
       ) cva 
       --, comisionprod       cp , v_productos        vp
 WHERE a.cagente = NVL(NVL(TO_CHAR(NULL), NULL), a.cagente)
   AND r.cempres = 24
   AND a.sperson = p.sperson
   AND a.ctipage = NVL(NULL, a.ctipage)
   AND r.cagente(+) = a.cagente
--   AND a.cagente = m.cagente
   AND a.ccomisi   = c.ccomisi
   AND d.ccomisi   = c.ccomisi
   AND d.cidioma   = 8
   AND a.cagente   = cva.cagente (+)
   AND a.ccomisi   = cva.ccomisi (+)
   /*AND a.ccomisi   = cp.ccomisi  (+)
--   AND cp.sproduc  = 8002 
--   AND a.cagente = 4000001
   AND cp.sproduc = vp.sproduc   
   AND cp.finivig = (SELECT MAX(finivig)
                       FROM comisionprod
                      WHERE cramo   = cp.cramo
                        AND sproduc = cp.sproduc
                        AND ccomisi = a.ccomisi
                     )*/
ORDER BY a.cagente;
--
SELECT cp.cramo, cp.sproduc || ' - ' || vp.ttitulo producto, cp.ccomisi, d.tcomisi, cp.pcomisi, cp.finivig
FROM comisionprod       cp , v_productos        vp, descomision        d
WHERE 1 = 1
  AND cp.sproduc = vp.sproduc   
   AND d.ccomisi   = cp.ccomisi
   AND d.cidioma   = 8
   AND cp.finivig = (SELECT MAX(finivig)
                       FROM comisionprod
                      WHERE cramo   = cp.cramo
                        AND sproduc = cp.sproduc
                        AND ccomisi = cp.ccomisi
                     )
ORDER BY cp.cramo, cp.ccomisi;
--
SELECT * FROM descomision; -- WHERE codigo = 'CONF_631';
SELECT * FROM mig_fin_indicadores;
--
--redComercial --2371
SELECT COUNT(*) FROM comisionprod; --6910
--
SELECT * FROM comisionprod s WHERE s.sproduc = 8002 AND s.ccomisi = 22;
SELECT * FROM all_tab_columns s WHERE s.OWNER = 'AXIS_D712' AND s.column_name = 'CCOMISI';
--
SELECT * FROM agentes WHERE cagente = 4000001;
SELECT * FROM CODICOMISIO;
SELECT * FROM COMISIONPROD WHERE sproduc = 8002;
SELECT * FROM COMISIONVIG_AGENTE s WHERE s.cagente = 4000001;
SELECT * FROM DESCOMISION s;
--
UPDATE descomision s
   SET s.tcomisi = ''
 WHERE s.cidioma = 8 AND s.ccomisi = 1;
--
SELECT * FROM ramos s;
SELECT * FROM v_productos s;
--
SELECT * FROM liquidacab s WHERE s.fcobro IS NOT NULL;
--
SELECT * FROM agentes WHERE cagente = 25;
