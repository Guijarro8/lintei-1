CREATE TABLE diputados (
 id TEXT NOT NULL,
 persona TEXT NOT NULL DEFAULT 'NULL',
 legislatura TEXT NOT NULL DEFAULT 'NULL',
 circunscripcion TEXT NOT NULL DEFAULT 'NULL',
 formacion_electoral TEXT,
 fecha_condicion_plena DATE,
 fecha_alta DATE NOT NULL DEFAULT 'NULL',
 fecha_baja DATE,
 grupo_parlamentario TEXT,
 fecha_alta_en_grupo_parlamentario DATE,
 fecha_baja_en_grupo_parlamentario DATE,
 biografia TEXT
);


ALTER TABLE diputados ADD CONSTRAINT diputados_pkey PRIMARY KEY (id);

CREATE TABLE votos (
 id TEXT NOT NULL,
 votacion TEXT NOT NULL DEFAULT 'NULL',
 voto TEXT/* An ENUM with possible values: "Sí", "No", "No vota" and NULL */,
 diputado TEXT NOT NULL DEFAULT 'NULL',
 persona TEXT NOT NULL DEFAULT 'NULL',
 grupo_parlamentario TEXT,
 asiento INTEGER
);


ALTER TABLE votos ADD CONSTRAINT votos_pkey PRIMARY KEY (id);
COMMENT ON COLUMN "votos"."voto" IS 'An ENUM with possible values: "Sí", "No", "No vota" and NULL';

CREATE TABLE votaciones (
 id TEXT NOT NULL,
 sesion TEXT NOT NULL DEFAULT 'NULL',
 fecha DATE NOT NULL DEFAULT 'NULL',
 titulo TEXT NOT NULL DEFAULT 'NULL',
 texto_expediente TEXT,
 titulo_subgrupo TEXT,
 texto_subgrupo TEXT,
 asentimiento BOOLEAN,
 a_favor INTEGER,
 en_contra INTEGER,
 abstenciones INTEGER,
 no_votan INTEGER
);


ALTER TABLE votaciones ADD CONSTRAINT votaciones_pkey PRIMARY KEY (id);

CREATE TABLE sesiones (
 id TEXT NOT NULL,
 legislatura TEXT
);


ALTER TABLE sesiones ADD CONSTRAINT sesiones_pkey PRIMARY KEY (id);

CREATE TABLE legislaturas (
 id TEXT NOT NULL,
 numero INTEGER NOT NULL,
 fecha_comienzo DATE NOT NULL DEFAULT 'NULL',
 fecha_final DATE/* Only null for active legislature */
);


ALTER TABLE legislaturas ADD CONSTRAINT legislaturas_pkey PRIMARY KEY (id);
COMMENT ON COLUMN "legislaturas"."fecha_final" IS 'Only null for active legislature';

CREATE TABLE grupos_parlamentarios (
 id TEXT NOT NULL,
 legislatura TEXT
);


ALTER TABLE grupos_parlamentarios ADD CONSTRAINT grupos_parlamentarios_pkey PRIMARY KEY (id);

CREATE TABLE formaciones (
 id TEXT NOT NULL,
 nombre TEXT
);


/*Automatically generated using WWW SQL Designer's Generate SQL tool*/

ALTER TABLE formaciones ADD CONSTRAINT formaciones_pkey PRIMARY KEY (id);

CREATE TABLE agrupaciones (
 id TEXT NOT NULL DEFAULT 'NULL',
 formacion_electoral TEXT,
 grupo_parlamentario TEXT
);


ALTER TABLE agrupaciones ADD CONSTRAINT agrupaciones_pkey PRIMARY KEY (id);

CREATE TABLE personas (
 id TEXT NOT NULL,
 nombre_completo TEXT NOT NULL DEFAULT 'NULL',
 nombre TEXT NOT NULL DEFAULT 'NULL',
 apellidos TEXT NOT NULL DEFAULT 'NULL'
);


ALTER TABLE personas ADD CONSTRAINT personas_pkey PRIMARY KEY (id);

CREATE TABLE cargos (
 id TEXT NOT NULL,
 persona TEXT,
 titulo TEXT,
 legislatura TEXT NOT NULL
);


ALTER TABLE cargos ADD CONSTRAINT cargos_pkey PRIMARY KEY (id);
COMMENT ON TABLE "cargos" IS 'Cargos de personas durante legislaturas. Esto depende de la persona y no el escaño. Por ejemplo, Presidenta de la Mesa';

ALTER TABLE diputados ADD CONSTRAINT diputados_persona_fkey FOREIGN KEY (persona) REFERENCES personas(id);
ALTER TABLE diputados ADD CONSTRAINT diputados_legislatura_fkey FOREIGN KEY (legislatura) REFERENCES legislaturas(id);
ALTER TABLE diputados ADD CONSTRAINT diputados_formacion_electoral_fkey FOREIGN KEY (formacion_electoral) REFERENCES formaciones(id);
ALTER TABLE diputados ADD CONSTRAINT diputados_grupo_parlamentario_fkey FOREIGN KEY (grupo_parlamentario) REFERENCES grupos_parlamentarios(id);
ALTER TABLE votos ADD CONSTRAINT votos_votacion_fkey FOREIGN KEY (votacion) REFERENCES votaciones(id);
ALTER TABLE votos ADD CONSTRAINT votos_diputado_fkey FOREIGN KEY (diputado) REFERENCES diputados(id);
ALTER TABLE votos ADD CONSTRAINT votos_persona_fkey FOREIGN KEY (persona) REFERENCES personas(id);
ALTER TABLE votos ADD CONSTRAINT votos_grupo_parlamentario_fkey FOREIGN KEY (grupo_parlamentario) REFERENCES grupos_parlamentarios(id);
ALTER TABLE votaciones ADD CONSTRAINT votaciones_sesion_fkey FOREIGN KEY (sesion) REFERENCES sesiones(id);
ALTER TABLE sesiones ADD CONSTRAINT sesiones_legislatura_fkey FOREIGN KEY (legislatura) REFERENCES legislaturas(id);
ALTER TABLE grupos_parlamentarios ADD CONSTRAINT grupos_parlamentarios_legislatura_fkey FOREIGN KEY (legislatura) REFERENCES legislaturas(id);
ALTER TABLE agrupaciones ADD CONSTRAINT agrupaciones_formacion_electoral_fkey FOREIGN KEY (formacion_electoral) REFERENCES formaciones(id);
ALTER TABLE agrupaciones ADD CONSTRAINT agrupaciones_grupo_parlamentario_fkey FOREIGN KEY (grupo_parlamentario) REFERENCES grupos_parlamentarios(id);
ALTER TABLE cargos ADD CONSTRAINT cargos_id_fkey FOREIGN KEY (id) REFERENCES personas(id);
ALTER TABLE cargos ADD CONSTRAINT cargos_legislatura_fkey FOREIGN KEY (legislatura) REFERENCES legislaturas(id);