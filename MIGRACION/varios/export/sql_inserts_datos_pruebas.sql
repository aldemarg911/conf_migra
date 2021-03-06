-- Datos de Pruebas
insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('A0555140', 'A0555140', 37, '9006254903', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, null, null, 19000, 'CONSORCIO INTERVIAS META', null, null, null, null, 170, null, 170, null, null, null, ' ', null);

insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('A0077138', 'A0077138', 37, '8000264703', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, null, null, 19000, 'GUEVARA BAQUERO CIA LTDA.', null, null, null, null, 170, null, 170, null, null, null, ' ', null);

insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('A0543803', 'A0543803', 37, '9003687295', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, null, null, 19000, 'MBM INGENIERIA SAS', null, null, null, null, 170, null, 170, null, null, null, ' ', null);

insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('A0021916', 'A0021916', 37, '8909801792', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, null, null, 19000, 'INSTITUTO PARA EL DESARROLLO DE ANTIOQUIA - IDEA', null, null, null, null, 170, null, 170, null, null, null, ' ', null);

insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('A0243127', 'A0243127', 37, '8300966201', 0, 2, to_date('17-10-2016', 'dd-mm-yyyy'), 1, null, null, 19000, 'PROFESIONALES EN TRANSACCIONES ELECTRONICAS S.A PTESA', null, null, null, null, 170, null, 170, null, null, null, ' ', null);

insert into Mig_Personas_Conf (MIG_PK, SNIP, CTIPIDE, NNUMIDE, CESTPER, CPERTIP, FULTMOD, SWPUBLI, CSEXPER, FNACIMI, CAGENTE, TAPELLI1, TAPELLI2, TNOMBRE, TNOMBRE2, CESTCIV, CPAIS, CPROFES, CNACIO, CTIPBAN, CBANCAR, CIDIOMA, TDIGITOIDE, FDEFUNC)
values ('900930211', '900930211-2', 37, '9009302112', 0, 2, to_date('03-03-2017', 'dd-mm-yyyy'), 1, null, null, 19000, 'SECAR SEGUROS LTDA', null, null, null, null, 170, null, 170, 107, '8554425098
', null, null, null);


insert into Mig_Personas_Rel_conf (MIG_PK, MIG_FK, FKREL, CTIPREL, PPARTICIPACION, ISLIDER)
values ('A0555140A0543803', 'A0555140', 'A0543803', 5, 50, 1);

insert into Mig_Personas_Rel_conf (MIG_PK, MIG_FK, FKREL, CTIPREL, PPARTICIPACION, ISLIDER)
values ('A0555140A0077138', 'A0555140', 'A0077138', 5, 50, null);


insert into MIG_DIRECCIONES_CONF (MIG_PK, MIG_FK, SPERSON, CAGENTE, CDOMICI, CPOSTAL, CPROVIN, CPOBLAC, TNOMVIA, CTIPDIR, CVIAVP, CLITVP, CBISVP, CORVP, NVIAADCO, CLITCO, CORCO, NPLACACO, COR2CO, CDET1IA, TNUM1IA, CDET2IA, TNUM2IA, CDET3IA, TNUM3IA, LOCALIDAD, TNUMTEL, TNUMFAX, TNUMMOV, TEMAIL, TALIAS)
values ('A05551401', 'A0555140', 0, 19000, 0, null, 11, 1, null, 9, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, 'CONSORCIO INTERVIAS META');

insert into MIG_DIRECCIONES_CONF (MIG_PK, MIG_FK, SPERSON, CAGENTE, CDOMICI, CPOSTAL, CPROVIN, CPOBLAC, TNOMVIA, CTIPDIR, CVIAVP, CLITVP, CBISVP, CORVP, NVIAADCO, CLITCO, CORCO, NPLACACO, COR2CO, CDET1IA, TNUM1IA, CDET2IA, TNUM2IA, CDET3IA, TNUM3IA, LOCALIDAD, TNUMTEL, TNUMFAX, TNUMMOV, TEMAIL, TALIAS)
values ('A05551403', 'A0555140', 0, 19000, 0, null, 11, 1, 'CL 147 A 53 15 OF I 201', 10, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '4586121', null, null, null, 'CONSORCIO INTERVIAS META');

insert into MIG_DIRECCIONES_CONF (MIG_PK, MIG_FK, SPERSON, CAGENTE, CDOMICI, CPOSTAL, CPROVIN, CPOBLAC, TNOMVIA, CTIPDIR, CVIAVP, CLITVP, CBISVP, CORVP, NVIAADCO, CLITCO, CORCO, NPLACACO, COR2CO, CDET1IA, TNUM1IA, CDET2IA, TNUM2IA, CDET3IA, TNUM3IA, LOCALIDAD, TNUMTEL, TNUMFAX, TNUMMOV, TEMAIL, TALIAS)
values ('900930211-21', '900930211', 0, 19000, 0, null, 13, 1, 'AV PI�ANGO 13 76', 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '6709332', null, '3183897776', 'anitacastillo1803@hotmail.com', 'SECAR SEGUROS LTDA');

insert into Mig_Per_Agr_Marcas_CONF (MIG_PK, MIG_FK, CMARCA, NMOVIMI, CTIPO, CTOMADOR, CCONSORCIO, CASEGURADO, CCODEUDOR, CBENEF, CACCIONISTA, CINTERMED, CREPRESEN, CAPODERADO, CPAGADOR, TOBSEVA, CUSER, FALTA)
values ('A0243127491', 'A0243127', '49', 0, 1, 1, null, null, null, null, null, null, null, null, null, null, 'GRIESGOS', to_date('21-03-2017 02:27:10', 'dd-mm-yyyy hh24:mi:ss'));

insert into Mig_Per_Agr_Marcas_CONF (MIG_PK, MIG_FK, CMARCA, NMOVIMI, CTIPO, CTOMADOR, CCONSORCIO, CASEGURADO, CCODEUDOR, CBENEF, CACCIONISTA, CINTERMED, CREPRESEN, CAPODERADO, CPAGADOR, TOBSEVA, CUSER, FALTA)
values ('A0243127492', 'A0555140', '49', 0, 1, 1, null, null, null, null, null, null, null, null, null, null, 'GRIESGOS', to_date('21-03-2017 02:27:10', 'dd-mm-yyyy hh24:mi:ss'));


insert into mig_agentes (NCARGA, CESTMIG, MIG_PK, MIG_FK, CAGENTE, IDPERSON, CTIPAGE, CACTIVO, CRETENC, CTIPIVA, CCOMISI, CPADRE, FMOVINI, FMOVFIN, CPERVISIO, CPERNIVEL, CPOLVISIO, CPOLNIVEL, FINIVIG, CTIPADN, CAGEDEP, CTIPINT, CAGECLAVE, COFERMERCAN, FRECEPCONTRA, CIDONEIDAD, SPERCOMP, CCOMPANI, COFIPROPIA, CCLASIF, NPLANPAGO, NNOTARIA, CPROVIN, CPOBLAC, NESCRITURA, FALTASOC, TGERENTE, TCAMARACOMERCIO, CSOBRECOMISI, TALIAS, CLIQUIDO, NREGDGS)
values (20041, 9, '900930211-2', '900930211', 8, 2918, 0, 1, 0, 0, 0, 2, to_date('06-07-2017 09:55:13', 'dd-mm-yyyy hh24:mi:ss'), null, 19000, 1, 19000, 1, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);


