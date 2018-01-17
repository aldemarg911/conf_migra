-- Create table
create table MIG_CTGAR_VEHICULO
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  cpais    NUMBER(3) not null,
  cprovin  NUMBER not null,
  cpoblac  NUMBER not null,
  cmarca   NUMBER,
  ctipo    NUMBER,
  nmotor   VARCHAR2(100),
  nplaca   VARCHAR2(10),
  ncolor   NUMBER,
  nserie   VARCHAR2(100),
  casegura NUMBER
);

-- Add comments to the columns 
comment on column MIG_CTGAR_VEHICULO.mig_pk
  is 'Clave �nica de MIG_CTGA_VEHICULO';
comment on column MIG_CTGAR_VEHICULO.mig_fk
  is 'Clave externa para MIG_CTGARDET';
comment on column MIG_CTGAR_VEHICULO.cpais
  is 'Pa�s';
comment on column MIG_CTGAR_VEHICULO.cprovin
  is 'Provincia';
comment on column MIG_CTGAR_VEHICULO.cpoblac
  is 'Municipio';
comment on column MIG_CTGAR_VEHICULO.cmarca
  is 'Marca del veh�culo V.F. 8001040';
comment on column MIG_CTGAR_VEHICULO.ctipo
  is 'Tipo de servicio vehicular V.F. 8001041';
comment on column MIG_CTGAR_VEHICULO.nmotor
  is 'N�mero del motor';
comment on column MIG_CTGAR_VEHICULO.nplaca
  is 'N�mero de placa';
comment on column MIG_CTGAR_VEHICULO.ncolor
  is 'Color veh�culo V.F. 8001042';
comment on column MIG_CTGAR_VEHICULO.nserie
  is 'N�mero de serie';
comment on column MIG_CTGAR_VEHICULO.casegura
  is 'Compa��a aseguradora V.F. 1126';
