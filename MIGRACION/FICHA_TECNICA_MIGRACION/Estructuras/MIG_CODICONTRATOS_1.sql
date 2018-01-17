DROP TABLE MIG_CODICONTRATOS;
-- Create table
create table MIG_CODICONTRATOS
(
  ncarga       NUMBER not null,
  cestmig      NUMBER not null,
  mig_pk       VARCHAR2(50) NOT NULL,
  mig_fk       VARCHAR2(50) NOT null,
  nversion     NUMBER,
  scontra      NUMBER,
  spleno       NUMBER(6),
  cempres      NUMBER(2),
  ctiprea      NUMBER(2),
  finictr      DATE,
  ffinctr      DATE,
  nconrel      NUMBER(6),
  sconagr      NUMBER(6),
  cvidaga      NUMBER(1),
  cvidair      NUMBER(1),
  ctipcum      NUMBER(1),
  cvalid       NUMBER(1),
  cretira      NUMBER(1),
  cmoneda      VARCHAR2(3),
  tdescripcion VARCHAR2(100),
  cdevento     NUMBER(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
