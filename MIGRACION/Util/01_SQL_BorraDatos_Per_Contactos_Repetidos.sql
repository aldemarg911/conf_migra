DELETE
SELECT COUNT(*)
SELECT *
  from PER_CONTACTOS P
  where 1 = 1
   and SPERSON IN (1120, 1567)
   and (SPERSON, CMODCON)  in (    select SPERSON, min(CMODCON)
                                        from PER_CONTACTOS
                                        where 1 = 1
                                          AND SPERSON = P.SPERSON
                                     group by SPERSON, CAGENTE, CTIPCON, RTRIM(LTRIM(TVALCON))
                                 );
-- SCRIPT DE KELLY (Solo deja los dos primeros registros :S)
SELECT COUNT(*)
--delete
    FROM  PER_CONTACTOS
   WHERE SPERSON IN ( SELECT DISTINCT(SPERSON)
                        FROM PER_CONTACTOS
                        --where sperson = 1567
                       GROUP BY TVALCON,SPERSON
                      HAVING COUNT(TVALCON) > 1)
    AND  CMODCON NOT IN(1,2);--173541 en 40 [s]. Tasa 4338/[s]
--
 -- Script Hugo: Deja los datos 
DELETE per_contactos p 
WHERE (SPERSON, CMODCON) NOT IN (
                                 select SPERSON, min(CMODCON)
                                  from PER_CONTACTOS
                                  where 1 = 1
                               group by SPERSON, CAGENTE, CTIPCON, RTRIM(LTRIM(TVALCON))
                             );
 
 
 --146540 en 33 [s]. Tasa 4440/[s]
 -- 
 ---***********************************----------------****************
