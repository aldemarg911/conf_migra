-- Create table
create table MIG_SIN_TRAMITA_JUD_DETPER
(
  ncarga   NUMBER,
  cestmig  NUMBER,
  mig_pk   VARCHAR2(50) not null,
  mig_fk   VARCHAR2(50) not null,
  mig_fk2  VARCHAR2(50) not null,
  norden   NUMBER(3) not null,
  nrol     NUMBER(3) not null,
  npersona NUMBER(3) not null,
  ntipper  NUMBER(8),
  nnumide  VARCHAR2(50),
  tnombre  VARCHAR2(200),
  iimporte NUMBER(19,2),
  fbaja    DATE,
  fmodifi  DATE,
  cusualt  VARCHAR2(20)
)
;
-- Add comments to the columns 
comment on column MIG_SIN_TRAMITA_JUD_DETPER.mig_pk
  is 'Clave única de MIG_SIN_TRAMITA_JUD_DETPER';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.mig_fk
  is 'Clave externa de MIG_SIN_SINIESTRO';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.mig_fk2
  is 'Clave externa de MIG_SIN_TRAMITA_JUDICIAL';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.norden
  is 'Numero Orden Proceso';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.nrol
  is 'Rol de persona (1 - Demandados/ 2 - Beneficiarios) ';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.npersona
  is 'Número de persona.';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.ntipper
  is 'Tipo Persona (VF 8001099 Cuando rol sea Beneficiarios) - (VF 800067 cuando rol de persona demandados)';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.nnumide
  is 'Número de Censo/Pasaporte de la persona';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.tnombre
  is 'Nombre de la persona';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.iimporte
  is 'Importe a pagar';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.fbaja
  is 'Fecha Baja Registro';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.fmodifi
  is 'Fecha Creación/Modificación';
comment on column MIG_SIN_TRAMITA_JUD_DETPER.cusualt
  is 'Código Usuario Alta';
