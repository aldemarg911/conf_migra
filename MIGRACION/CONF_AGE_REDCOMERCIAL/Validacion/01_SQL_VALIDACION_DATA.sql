--PerYaExisten_Prod
     --select  count(mpc.mig_pk)
     SELECT mpc.mig_pk, mpc.SNIP, p.snip snip_iaxis, mpc.CTIPIDE, mpc.NNUMIDE, mpc.tnombre, mpc.tapelli1, p.sperson, (select tnombre
                                                                                                 from per_detper 
                                                                                                where sperson = p.sperson) tnombre_iaxis, 
                                                                                               (select tapelli1
                                                                                                 from per_detper 
                                                                                                where sperson = p.sperson) tapelli1_iaxis
       
       FROM transformacion.mig_personas_conf mpc, per_personas p
      WHERE 1 = 1
        AND mpc.nnumide = p.nnumide
        AND mpc.ctipide = p.ctipide
        AND  (    mpc.ctipide  IS NOT NULL 
              AND mpc.cestper  IS NOT NULL 
              AND mpc.cpertip  IS NOT NULL
              AND mpc.swpubli  IS NOT NULL
              AND mpc.tapelli1 IS NOT NULL
             )
        AND (SELECT COUNT(sperson) 
               FROM per_personas 
              WHERE nnumide = mpc.nnumide
                AND ctipide = mpc.ctipide) > 0
    ORDER BY mpc.CTIPIDE, mpc.NNUMIDE;
--
SELECT count(*) FROM transformacion.mig_personas_conf mpc;
  SELECT * FROM mig_agentes;
    SELECT * FROM transformacion.mig_agentes_conf;
--
       SELECT COUNT(*) FROM transformacion.mig_personas_conf mpc
      WHERE 1 = 1
        AND mpc.nnumide IS NOT NULL
        AND  (    ctipide  IS NOT NULL 
             AND cpertip  IS NOT NULL
              AND swpubli  IS NOT NULL
                 AND cestper  IS NOT NULL 
            AND tapelli1 IS NOT NULL
             )
        AND mig_pk NOT IN (SELECT DISTINCT mpc.mig_pk
                             FROM transformacion.mig_personas_conf mpc, per_personas p
                            WHERE 1 = 1
                              AND mpc.nnumide = p.nnumide
                              AND mpc.ctipide = p.ctipide
                              AND  (    mpc.ctipide  IS NOT NULL 
                                    AND mpc.cestper  IS NOT NULL 
                                    AND mpc.cpertip  IS NOT NULL
                                    AND mpc.swpubli  IS NOT NULL
                                    AND mpc.tapelli1 IS NOT NULL
                                   )
                              AND (SELECT COUNT(sperson) 
                                     FROM per_personas 
                                    WHERE nnumide = mpc.nnumide
                                      AND ctipide = mpc.ctipide) > 0)      
