create table MIG_DETMOVRECIBO
(
  NCARGA    NUMBER NOT NULL,
  CESTMIG   NUMBER NOT NULL,
  MIG_PK    VARCHAR2(50) NOT NULL,
  MIG_FK    VARCHAR2(50) NOT NULL,
  NRECIBO   NUMBER NOT NULL,
  SMOVREC   NUMBER NOT NULL, 
  NORDEN    NUMBER(2) NOT NULL,
  IIMPORTE  NUMBER NOT NULL,
  FMOVIMI   DATE NOT NULL,
  FEFEADM   DATE,
  CUSUARI   VARCHAR2(34) NOT NULL,
  TDESCRIP  VARCHAR2(1000),
  FCONTAB   DATE,
  IIMPORTE_MONCON      NUMBER,
  FCAMBIO   DATE
);
--
comment on column MIG_DETMOVRECIBO.MIG_PK   is 'Clave única de MIG_DETMOVRECIBO';
comment on column MIG_DETMOVRECIBO.MIG_FK   is 'Clave externa para MIG_RECIBOS';
comment on column MIG_DETMOVRECIBO.SMOVREC  is 'Secuencial del movimiento';
comment on column MIG_DETMOVRECIBO.NORDEN   is 'Número de movimiento';
comment on column MIG_DETMOVRECIBO.nrecibo  is 'Número de recibo.';
comment on column MIG_DETMOVRECIBO.IIMPORTE   is 'Importe Cobrado';
comment on column MIG_DETMOVRECIBO.FMOVIMI   is 'Fecha de movimiento';
comment on column MIG_DETMOVRECIBO.FEFEADM   is 'Fecha efecto del movimiento a nivel administrativo';
comment on column MIG_DETMOVRECIBO.CUSUARI   is 'Usuario que realiza el movimiento';
comment on column MIG_DETMOVRECIBO.TDESCRIP   is 'Descripción del apunte';
comment on column MIG_DETMOVRECIBO.FCONTAB   is 'Fecha de contabilidad';
comment on column MIG_DETMOVRECIBO.IIMPORTE_MONCON   is 'Importe cobrado moneda de la contabilidad';
comment on column MIG_DETMOVRECIBO.FCAMBIO   is 'Fecha de cambio';
-- Create/Recreate indexes 
create index MIG_DETMOVRECIBO_NCARGA on MIG_DETMOVRECIBO(NCARGA);
-- Create/Recreate primary, unique and foreign key constraints 
alter table MIG_DETMOVRECIBO
  add constraint MIG_DETMOVRECIBO_PK primary key (MIG_PK);
--
