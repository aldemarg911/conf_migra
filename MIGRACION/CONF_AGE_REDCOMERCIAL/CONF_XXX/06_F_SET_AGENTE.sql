CREATE OR REPLACE FUNCTION f_set_agente(pcempres IN NUMBER,
                                        pctipage IN NUMBER) RETURN NUMBER IS
   i NUMBER;
   v NUMBER;
BEGIN
   i := pac_redcomercial.f_get_contador_agente(pcempres, pctipage, v);
   RETURN v;
END f_set_agente;
/