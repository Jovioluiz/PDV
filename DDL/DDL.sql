ALTER TABLE public.usuarios ALTER COLUMN senha TYPE varchar(50) USING senha::varchar;

CREATE SEQUENCE public.usuario_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1
	NO CYCLE;

ALTER TABLE public.funcionarios ADD cd_usuario int2 NULL;

ALTER TABLE public.usuarios DROP CONSTRAINT fk_usuarios_funcionarios;
ALTER TABLE public.usuarios DROP COLUMN cd_funcionario;

ALTER TABLE public.funcionarios ADD CONSTRAINT funcionarios_fk FOREIGN KEY (cd_usuario) REFERENCES public.usuarios(cd_usuario) ON DELETE SET NULL;