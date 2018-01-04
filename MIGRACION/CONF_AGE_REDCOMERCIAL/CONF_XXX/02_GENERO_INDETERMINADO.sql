BEGIN
   INSERT INTO detvalores
      (cvalor, cidioma, catribu, tatribu)
   VALUES
      (11, 8, 0, 'Indeterminado');
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/
