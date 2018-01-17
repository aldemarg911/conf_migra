--
-- Deducibles o Franquicias [bf_bonfranseg]
--
SELECT * FROM all_source s where s.owner = 'AXIS' AND upper(s.text) LIKE UPPER('%insert into bf_bonfranseg%');
SELECT * FROM bf_bonfranseg s;
SELECT * FROM bf_bonfrancar;
SELECT * FROM bf_bonfransegcar;
--
SELECT * FROM bf_desgrup WHERE cgrup = 200035;
SELECT * FROM bf_codgrup WHERE cgrup = 200035;
SELECT * FROM bf_desgrupsubgrup;
SELECT * FROM bf_desnivel WHERE cidioma = 8 AND cgrup = 200035;
SELECT * FROM bf_detnivel WHERE cgrup = 200000;
--
SELECT * FROM BF_DESGRUPSUBGRUP;
SELECT * FROM BF_DESGRUPSUBGRUP s WHERE CEMPRES = 24 AND CIDIOMA = 8;
--
SELECT * FROM seguros s WHERE 1 = 1 AND s.npoliza = '802000142';  
SELECT * FROM BF_PROACTGRUP s;
SELECT * FROM BF_PROGARANGRUP s WHERE 1 = 1 AND s.codgrup = 200035
SELECT * FROM BF_PROACTGRUP s WHERE cgrup = 200000;
SELECT * FROM BF_BONFRANSEG s WHERE sseguro = 4692;
--
SELECT gg.sproduc, gg.cactivi, gg.cgarant, gg.codgrup, d.csubgrup, d.cversion, d.cnivel, cg.ctipgrup, d.tnivel
FROM bf_desnivel d, bf_progarangrup gg, bf_codgrup cg
WHERE d.cempres = 24 
AND d.cidioma = 8 --2990, 843
AND gg.cempres = d.cempres
AND gg.codgrup = d.cgrup
AND cg.cgrup   = gg.codgrup
--AND d.cgrup = 200035
ORDER BY 1, 2, 8;
--
