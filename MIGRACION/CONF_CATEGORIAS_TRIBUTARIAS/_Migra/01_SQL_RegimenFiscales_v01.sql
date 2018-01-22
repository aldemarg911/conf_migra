--
-- Regimen Fiscales
SELECT r.ctipper, ff_desvalorfijo(85, 8, r.ctipper) tip_per, r.cregfiscal, ff_desvalorfijo(1045, 8, r.cregfiscal) cregfis
FROM regimen_fiscal r;
--
SELECT * FROM DESCRIPCIONRET WHERE cidioma = 8;
--
SELECT * FROM CODIGORET;
SELECT * FROM retenciones;
--
-- Retenciones
SELECT r.cretenc, d.ttipret, r.finivig, r.pretenc, r.ffinvig, r.ctipind
FROM retenciones r, DESCRIPCIONRET d
where r.cretenc = d.cretenc and cidioma = 8
order by 1;
--
SELECT * FROM Per_Regimenfiscal;
SELECT * FROM agentes;
SELECT * FROM DESCRIPCIONRET WHERE cidioma = 8;
--
--Tipos IVA
select ti.*, i.tindica, i.carea, i.ccindid
from tipoiva ti, tipos_indicadores i
where ti.ctipind = i.ctipind (+)
order by ctipiva;
--

--
UPDATE INT_HOSTB2B SEt url = REPLACE(URL, '192.', '199.')
where cinterf = 'I017';