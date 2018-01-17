-- Create table
create table MIG_DATSARLAFT
(
  ncarga             NUMBER not null,
  cestmig            NUMBER not null,
  mig_pk             VARCHAR2(50) not null,
  mig_fk             VARCHAR2(50) not null,
  ssarlaft           NUMBER  not null,
  fradica            DATE,
  sperson            NUMBER  not null,
  fdiligencia        DATE,
  cauttradat         NUMBER,
  crutfcc            NUMBER,
  cestconf           NUMBER,
  fconfir            DATE,
  cvinculacion       NUMBER,
  cvintomase         NUMBER,
  tvintomase         VARCHAR2(150),
  cvintomben         NUMBER,
  tvintombem         VARCHAR2(150),
  cvinaseben         NUMBER,
  tvinasebem         VARCHAR2(150),
  tactippal          VARCHAR2(150),
  nciiuppal          NUMBER,
  tocupacion         VARCHAR2(150),
  tcargo             VARCHAR2(150),
  tempresa           VARCHAR2(150),
  tdirempresa        VARCHAR2(150),
  ttelempresa        VARCHAR2(150),
  tactisec           VARCHAR2(150),
  nciiusec           NUMBER,
  tdirsec            VARCHAR2(150),
  ttelsec            VARCHAR2(150),
  tprodservcom       VARCHAR2(150),
  iingresos          NUMBER,
  iactivos           NUMBER,
  ipatrimonio        NUMBER,
  iegresos           NUMBER,
  ipasivos           NUMBER,
  iotroingreso       NUMBER,
  tconcotring        VARCHAR2(150),
  cmanrecpub         NUMBER,
  cpodpub            NUMBER,
  crecpub            NUMBER,
  cvinperpub         NUMBER,
  tvinperpub         VARCHAR2(150),
  cdectribext        NUMBER,
  tdectribext        VARCHAR2(150),
  torigfond          VARCHAR2(150),
  ctraxmodext        NUMBER,
  ttraxmodext        VARCHAR2(150),
  cprodfinext        NUMBER,
  cctamodext         NUMBER,
  totrasoper         VARCHAR2(150),
  creclindseg        NUMBER,
  tciudadsuc         NUMBER,
  tpaisuc            NUMBER,
  tciudad            NUMBER,
  tpais              NUMBER,
  tlugarexpedidoc    NUMBER,
  resociedad         NUMBER,
  tnacionali2        NUMBER,
  ngradopod          NUMBER,
  ngozrec            NUMBER,
  nparticipa         NUMBER,
  nvinculo           NUMBER,
  ntipdoc            NUMBER,
  fexpedicdoc        DATE,
  fnacimiento        DATE,
  nrazonso           VARCHAR2(150),
  tnit               VARCHAR2(150),
  tdv                VARCHAR2(150),
  toficinapri        VARCHAR2(150),
  ttelefono          VARCHAR2(150),
  tfax               VARCHAR2(150),
  tsucursal          VARCHAR2(150),
  ttelefonosuc       VARCHAR2(150),
  tfaxsuc            VARCHAR2(150),
  ctipoemp           VARCHAR2(150),
  tcualtemp          VARCHAR2(150),
  tsector            VARCHAR2(150),
  tciiu              VARCHAR2(150),
  tactiaca           VARCHAR2(150),
  trepresentanle     VARCHAR2(150),
  tsegape            VARCHAR2(150),
  tnombres           VARCHAR2(150),
  tnumdoc            VARCHAR2(150),
  tlugnaci           VARCHAR2(150),
  tnacionali1        VARCHAR2(150),
  tindiquevin        VARCHAR2(150),
  per_papellido      VARCHAR2(150),
  per_sapellido      VARCHAR2(150),
  per_nombres        VARCHAR2(150),
  per_tipdocument    NUMBER,
  per_document       VARCHAR2(150),
  per_fexpedicion    DATE,
  per_lugexpedicion  NUMBER,
  per_fnacimi        DATE,
  per_lugnacimi      NUMBER,
  per_nacion1        NUMBER,
  per_direreci       VARCHAR2(150),
  per_pais           NUMBER,
  per_ciudad         NUMBER,
  per_departament    NUMBER,
  per_email          VARCHAR2(150),
  per_telefono       VARCHAR2(150),
  per_celular        VARCHAR2(150),
  nrecpub            NUMBER,
  tpresetreclamaci   NUMBER,
  per_tlugexpedicion VARCHAR2(150),
  per_tlugnacimi     VARCHAR2(150),
  per_tnacion1       VARCHAR2(150),
  per_tnacion2       VARCHAR2(150),
  per_tpais          VARCHAR2(150),
  per_tdepartament   VARCHAR2(150),
  per_tciudad        VARCHAR2(150),
  emptpais           VARCHAR2(150),
  emptdepatamento    VARCHAR2(150),
  emptciudad         VARCHAR2(150),
  emptpaisuc         VARCHAR2(150),
  emptdepatamentosuc VARCHAR2(150),
  emptciudadsuc      VARCHAR2(150),
  emptlugnaci        VARCHAR2(150),
  emptnacionali1     VARCHAR2(150),
  emptnacionali2     VARCHAR2(150),
  csujetooblifacion  NUMBER,
  FALTA              DATE,
  CUSUALT            VARCHAR2(32)
)
;
-- Add comments to the columns 
comment on column MIG_DATSARLAFT.mig_pk
  is 'Clave única de MIG_DATSARLAFT';
comment on column MIG_DATSARLAFT.mig_fk
  is 'Clave externa para MIG_PERSONAS';
comment on column MIG_DATSARLAFT.fradica
  is 'F. Radicación';
comment on column MIG_DATSARLAFT.sperson
  is 'Código de Persona (Nulo en este caso)';
comment on column MIG_DATSARLAFT.fdiligencia
  is 'F. Diligenciamiento';
comment on column MIG_DATSARLAFT.cauttradat
  is 'Aut. Tratamiento datos';
comment on column MIG_DATSARLAFT.crutfcc
  is 'Ruta del FCC (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.cestconf
  is 'Estado confirmación (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.fconfir
  is 'Fecha Confirmación';
comment on column MIG_DATSARLAFT.cvinculacion
  is 'Clase de vinculación';
comment on column MIG_DATSARLAFT.cvintomase
  is 'Vínculos existentes entre TOMADOR, ASEGURADO, AFIANZADO Y BENEFICIARIO';
comment on column MIG_DATSARLAFT.tvintomase
  is 'Otra vinculación';
comment on column MIG_DATSARLAFT.cvintomben
  is 'Vínculos existentes entre TOMADOR, ASEGURADO, AFIANZADO Y BENEFICIARIO';
comment on column MIG_DATSARLAFT.tvintombem
  is 'Otra vinculación ';
comment on column MIG_DATSARLAFT.cvinaseben
  is 'Vínculos existentes entre TOMADOR, ASEGURADO, AFIANZADO Y BENEFICIARIO';
comment on column MIG_DATSARLAFT.tvinasebem
  is 'Otra vinculación';
comment on column MIG_DATSARLAFT.tactippal
  is 'Actividad principal';
comment on column MIG_DATSARLAFT.nciiuppal
  is 'CIIU';
comment on column MIG_DATSARLAFT.tocupacion
  is 'Ocupación';
comment on column MIG_DATSARLAFT.tcargo
  is 'Cargo';
comment on column MIG_DATSARLAFT.tempresa
  is 'Empresa donde trabaja';
comment on column MIG_DATSARLAFT.tdirempresa
  is 'Dirección oficina';
comment on column MIG_DATSARLAFT.ttelempresa
  is 'Teléfono oficina';
comment on column MIG_DATSARLAFT.tactisec
  is 'Actividad secundaria';
comment on column MIG_DATSARLAFT.nciiusec
  is 'CIIU';
comment on column MIG_DATSARLAFT.tdirsec
  is 'Dirección';
comment on column MIG_DATSARLAFT.ttelsec
  is 'Teléfono';
comment on column MIG_DATSARLAFT.tprodservcom
  is 'Qué tipo de producto y/o servicio comercializa?';
comment on column MIG_DATSARLAFT.iingresos
  is 'Ingresos Mensuales';
comment on column MIG_DATSARLAFT.iactivos
  is 'Activos';
comment on column MIG_DATSARLAFT.ipatrimonio
  is 'Patrimonio';
comment on column MIG_DATSARLAFT.iegresos
  is 'Egresos mensuales';
comment on column MIG_DATSARLAFT.ipasivos
  is 'Pasivo';
comment on column MIG_DATSARLAFT.iotroingreso
  is 'Otros ingresos';
comment on column MIG_DATSARLAFT.tconcotring
  is 'Concepto ingresos mensuales';
comment on column MIG_DATSARLAFT.cmanrecpub
  is 'Por su cargo o actividad maneja recursos públicos? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.cpodpub
  is 'Por su cargo o actividad ejerce algún grado de poder público? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.crecpub
  is 'Por su actividad u oficio goza usted de reconocimiento público general? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.cvinperpub
  is 'Existe algún vínculo entre usted y una persona considerada públicamente expuesta? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.tvinperpub
  is 'Indique';
comment on column MIG_DATSARLAFT.torigfond
  is 'Orígenes de fondos';
comment on column MIG_DATSARLAFT.ctraxmodext
  is 'Realiza transacciones en moneda extranjera ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.ttraxmodext
  is 'Cual';
comment on column MIG_DATSARLAFT.cprodfinext
  is 'Posee productos financieros en el exterior ? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.cctamodext
  is 'Posee cuentas en moneda extranjera? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.totrasoper
  is 'Indique otras operaciones';
comment on column MIG_DATSARLAFT.tciudadsuc
  is 'Ciudad de la Sucursal';
comment on column MIG_DATSARLAFT.tpaisuc
  is 'País de la Sucursal';
comment on column MIG_DATSARLAFT.tciudad
  is 'Ciudad de la Sucursal';
comment on column MIG_DATSARLAFT.tpais
  is 'País de Residencia';
comment on column MIG_DATSARLAFT.tlugarexpedidoc
  is 'Lugar expedición';
comment on column MIG_DATSARLAFT.resociedad
  is 'Residencia de la sociedad';
comment on column MIG_DATSARLAFT.tnacionali2
  is 'Nacionalidad 2';
comment on column MIG_DATSARLAFT.ngradopod
  is 'Por su cargo o actividad ejerce algún grado de poder público? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.ngozrec
  is 'Por su actividad u oficio, goza usted de reconocimiento público general? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.nparticipa
  is 'Posee participación superior al 5%? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.nvinculo
  is 'Existe algún vínculo entre usted y una persona considerada públicamente expuesta? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.ntipdoc
  is 'Tipo de identificación persona (NIF, pasaporte, etc.)';
comment on column MIG_DATSARLAFT.fexpedicdoc
  is 'Fecha Expedición';
comment on column MIG_DATSARLAFT.fnacimiento
  is 'Fecha nacimiento';
comment on column MIG_DATSARLAFT.nrazonso
  is 'Nombre o razón social';
comment on column MIG_DATSARLAFT.tnit
  is 'NIT';
comment on column MIG_DATSARLAFT.tdv
  is 'DV';
comment on column MIG_DATSARLAFT.toficinapri
  is 'Oficina Principal Dirección';
comment on column MIG_DATSARLAFT.ttelefono
  is 'Teléfono';
comment on column MIG_DATSARLAFT.tfax
  is 'Fax';
comment on column MIG_DATSARLAFT.tsucursal
  is 'Sucursal o agencia Dirección';
comment on column MIG_DATSARLAFT.ttelefonosuc
  is 'Teléfono';
comment on column MIG_DATSARLAFT.tfaxsuc
  is 'Fax';
comment on column MIG_DATSARLAFT.ctipoemp
  is 'Tipo de empresa';
comment on column MIG_DATSARLAFT.tcualtemp
  is 'Otra, cuál?';
comment on column MIG_DATSARLAFT.tsector
  is 'Sector de la económica-a';
comment on column MIG_DATSARLAFT.tciiu
  is 'CIIU';
comment on column MIG_DATSARLAFT.tactiaca
  is 'Actividad económica';
comment on column MIG_DATSARLAFT.trepresentanle
  is 'Representante legal Primer Apellido';
comment on column MIG_DATSARLAFT.tsegape
  is 'Segundo Apellido';
comment on column MIG_DATSARLAFT.tnombres
  is 'Nombres';
comment on column MIG_DATSARLAFT.tnumdoc
  is 'Número de Identificación';
comment on column MIG_DATSARLAFT.tlugnaci
  is 'Lugar de nacimiento';
comment on column MIG_DATSARLAFT.tnacionali1
  is 'Nacionalidad 1';
comment on column MIG_DATSARLAFT.tindiquevin
  is 'Indique';
comment on column MIG_DATSARLAFT.per_papellido
  is 'Primer Apellido';
comment on column MIG_DATSARLAFT.per_sapellido
  is 'Segundo Apellido';
comment on column MIG_DATSARLAFT.per_nombres
  is 'Nombres';
comment on column MIG_DATSARLAFT.per_tipdocument
  is 'Tipo de identificación persona (NIF, pasaporte, etc.)';
comment on column MIG_DATSARLAFT.per_document
  is 'Documento';
comment on column MIG_DATSARLAFT.per_fexpedicion
  is 'Fecha Expedición';
comment on column MIG_DATSARLAFT.per_lugexpedicion
  is 'Nacionalidad 2';
comment on column MIG_DATSARLAFT.per_fnacimi
  is 'Fecha nacimiento';
comment on column MIG_DATSARLAFT.per_lugnacimi
  is 'Lugar de nacimiento';
comment on column MIG_DATSARLAFT.per_nacion1
  is 'Nacionalidad 1';
comment on column MIG_DATSARLAFT.per_direreci
  is 'Dirección residencia';
comment on column MIG_DATSARLAFT.per_pais
  is 'País de residencia';
comment on column MIG_DATSARLAFT.per_ciudad
  is 'Ciudad de residencia';
comment on column MIG_DATSARLAFT.per_departament
  is 'Departamento de residencia';
comment on column MIG_DATSARLAFT.per_email
  is 'Email';
comment on column MIG_DATSARLAFT.per_telefono
  is 'Teléfono';
comment on column MIG_DATSARLAFT.per_celular
  is 'Celular';
comment on column MIG_DATSARLAFT.nrecpub
  is 'Por su cargo o actividad maneja recursos públicos?';
comment on column MIG_DATSARLAFT.tpresetreclamaci
  is 'Ha presentado reclamaciones o ha recibido indemnizaciones en seguros en los dos Últimos aC1os? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.per_tlugexpedicion
  is 'Nacionalidad 2';
comment on column MIG_DATSARLAFT.per_tlugnacimi
  is 'Lugar de nacimiento';
comment on column MIG_DATSARLAFT.per_tnacion1
  is 'Nacionalidad 1';
comment on column MIG_DATSARLAFT.per_tnacion2
  is 'Nacionalidad 2';
comment on column MIG_DATSARLAFT.per_tpais
  is 'País de residencia';
comment on column MIG_DATSARLAFT.per_tdepartament
  is 'Departamento de residencia';
comment on column MIG_DATSARLAFT.per_tciudad
  is 'Ciudad de residencia';
comment on column MIG_DATSARLAFT.emptpais
  is 'País de la empresa';
comment on column MIG_DATSARLAFT.emptdepatamento
  is 'Departamento de la empresa';
comment on column MIG_DATSARLAFT.emptciudad
  is 'Ciudad de la empresa';
comment on column MIG_DATSARLAFT.emptpaisuc
  is 'País de la sucursal';
comment on column MIG_DATSARLAFT.emptdepatamentosuc
  is 'Departamento de la sucursal';
comment on column MIG_DATSARLAFT.emptciudadsuc
  is 'Ciudad de la sucursal';
comment on column MIG_DATSARLAFT.emptlugnaci
  is 'Lugar de nacimiento';
comment on column MIG_DATSARLAFT.emptnacionali1
  is 'Nacionalidad 1';
comment on column MIG_DATSARLAFT.emptnacionali2
  is 'Nacionalidad 2';
comment on column MIG_DATSARLAFT.csujetooblifacion
  is 'Es usted sujeto de obligaciones tributarias en otro país o grupo de países? (V.F. 828 0= No, 1 = Si)';
comment on column MIG_DATSARLAFT.FALTA   is 'Fecha Alta';
comment on column MIG_DATSARLAFT.CUSUALT   is 'Usuario Alta';
--
create index MIG_DATSARLAFT_NCARGA on MIG_DATSARLAFT (NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_DATSARLAFT
  add constraint MIG_DATSARLAFT_PK primary key (MIG_PK);
