--
SELECT * FROM pds_config_user s WHERE cuser IN ('BUITRAGOM', 'CAMARGOA', 'DMADIEDO', 'PBUCARAMANGA'); 
SELECT * FROM PDS_CONFIG_COD_ACCION s WHERE 1 = 1; 
SELECT * FROM PDS_CONFIG_COD_FORM s WHERE 1 = 1;       
SELECT * FROM USUARIOS s WHERE 1 = 1 AND cusuari = 'PBUCARAMANGA';   
SELECT * FROM PDS_COD_SUPLEM s WHERE 1 = 1;    
SELECT * FROM PDS_CONFIG_COD_WIZARD s WHERE 1 = 1;  
SELECT * FROM cfg_user s WHERE 1 = 1 AND cuser = 'PBUCARAMANGA';
--
		SELECT crolmen FROM MENU_CODIROLMEN WHERE cuser IN ('BUITRAGOM', 'CAMARGOA', 'DMADIEDO', 'PBUCARAMANGA'); 
		SELECT DISTINCT crolmen FROM MENU_CODIROLMEN  WHERE cuser IN ('BUITRAGOM', 'CAMARGOA', 'DMADIEDO', 'PBUCARAMANGA'); 
		SELECT *  FROM menu_usercodirol  WHERE cuser IN ('BUITRAGOM', 'CAMARGOA', 'DMADIEDO', 'PBUCARAMANGA'); 
		SELECT *  FROM cfg_user ;
		SELECT *  FROM usu_datos ;
		SELECT *  FROM pds_config_user ;
		SELECT *  FROM usuarios ;
