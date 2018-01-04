PL/SQL Developer Test script 3.0
77
-- Created on 27/07/2017 by HGOMEZ 
declare 
  -- Local variables here
      num_err   NUMBER;
      v_error   BOOLEAN := FALSE;
      v_error_i BOOLEAN := FALSE;
      v_ccompani companias.ccompani%TYPE;
      --
      l_mensajes t_iax_mensajes;
      --
      CURSOR lc_mig_companias IS
      SELECT c.mig_pk, c.mig_fk, c.ccompani, c.tcompani, c.ctipcom, p.idperson
        FROM mig_companias c, mig_personas p
       WHERE 1 = 1
         AND c.ncarga    = 20047 --pncarga
         AND c.cestmig   = 1
         AND c.mig_fk    = p.mig_pk
         AND p.idperson != 0
         --AND c.ncarga  = p.ncarga
         AND p.mig_pk = '860069195'         
         ;
begin
  -- Test statements here  
  FOR x IN lc_mig_companias 
  LOOP
    --
    v_ccompani := NULL;
    v_error_i    := FALSE;
    --
    num_err := pac_md_companias.f_set_compania(psperson     => x.idperson,
                                               pccompani    => v_ccompani,
                                               ptcompani    => x.tcompani,
                                               pcpais       => 170,
                                               pctipiva     => 0,
                                               pccomisi     => NULL,
                                               pcunespa     => NULL,
                                               pffalta      => f_sysdate,
                                               pfbaja       => NULL,
                                               pccontable   => NULL,
                                               pctipcom     => 0,
                                               pcafili      => NULL,
                                               pccasamat    => NULL,
                                               pcsuperfinan => NULL,
                                               pcdian       => NULL,
                                               pccalifi     => NULL,
                                               pcenticalifi => NULL,
                                               pnanycalif   => NULL,
                                               pnpatrimonio => NULL,
                                               ppimpint     => NULL,
                                               pctramtax    => NULL,
                                               pcinverfas   => NULL,
                                               mensajes     => l_mensajes);
      --
      FOR i IN (SELECT p.*
                FROM TABLE(l_mensajes) p)
      LOOP
        --
        IF i.cerror = 111313 -- Proceso Correcto. (No es error)
        THEN
          --
          NULL;
          --
        ELSE
          --
      dbms_output.put_line( x.mig_pk ||' - Error:' || i.cerror || '-' || i.terror || ' lineap: '|| dbms_utility.format_error_backtrace); 
          v_error_i := TRUE;
          v_error   := TRUE;
          --
        END IF;
        --
      END LOOP;
      --
      dbms_output.put_line('v_ccompani:'||v_ccompani);    
      --
 END LOOP;
 --  
end;
0
0
