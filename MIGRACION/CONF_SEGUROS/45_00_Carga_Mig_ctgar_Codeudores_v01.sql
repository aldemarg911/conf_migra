DECLARE
pncarga NUMBER := 17426;
pntab   NUMBER := 25;
num_err   NUMBER := 0;
v_paso  VARCHAR2(40);
   FUNCTION f_ins_mig_logs_axis(
      pncarga IN NUMBER,
      pmig_pk IN VARCHAR2,
      ptipo IN VARCHAR2,
      ptexto IN VARCHAR2)
      RETURN NUMBER IS
      PRAGMA AUTONOMOUS_TRANSACTION;
      v_seq          NUMBER;
   BEGIN
      SELECT sseqlogmig2.NEXTVAL
        INTO v_seq
        FROM DUAL;

      INSERT INTO mig_logs_axis
                  (ncarga, seqlog, fecha, mig_pk, tipo, incid)
           VALUES (pncarga, v_seq, f_sysdate, pmig_pk, ptipo, ptexto);

      COMMIT;
      RETURN 0;
   EXCEPTION
      WHEN OTHERS THEN
         RETURN SQLCODE;
   END f_ins_mig_logs_axis;
BEGIN
               --Codeudores de la contragarantía
               FOR ctgar_codeu IN (SELECT a.*, p.idperson p_Sperson_codeu, c.scontgar c_scontgar
                                    --select count(*)
                                     FROM mig_ctgar_contragarantia c, mig_ctgar_codeudor a, mig_personas p
                                    WHERE 1 = 1
                                      AND a.ncarga = 17426
                                      AND a.cestmig = 1
                                      AND a.mig_fk = c.mig_pk
                                      AND a.mig_fk2 = p.mig_pk
                                      ORDER BY a.mig_pk)
               LOOP
                  --
                  BEGIN
                    --
                    v_paso := 'ctgar_codeu';
                    --
                    INSERT INTO ctgar_codeudor
                       (scontgar, nmovimi, sperson)
                    VALUES
                       (ctgar_codeu.c_scontgar, 1, ctgar_codeu.p_Sperson_codeu);
                     --
                     INSERT INTO mig_pk_mig_axis
                     VALUES (ctgar_codeu.mig_pk, pncarga, pntab, 5, ctgar_codeu.c_scontgar ||' - '|| ctgar_codeu.p_Sperson_codeu);
                     --
                     UPDATE mig_ctgar_codeudor
                        SET cestmig  = 2
                     WHERE mig_pk = ctgar_codeu.mig_pk;
                     --
                     COMMIT;
                  EXCEPTION
                     WHEN OTHERS THEN
                        --
                        num_err := f_ins_mig_logs_axis(pncarga, ctgar_codeu.mig_pk, 'E',
                                                       v_paso || ' - Error insertar contragarantía: ' ||
                                                        SQLERRM);
                        --
                        ROLLBACK;
                        -- 
                  END;
                  --
               END LOOP;
END;
--
SELECT * FROM mig_logs_axis s WHERE s.incid LIKE 'ctgar_codeu%';
SELECT * FROM mig_logs_axis s WHERE s.ncarga = 17470;
SELECT * FROM MIG_CTATECNICA s;
SELECT * FROM CTATECNICA s
