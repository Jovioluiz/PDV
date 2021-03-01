CREATE SEQUENCE public.cliente_seq
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1
    NO CYCLE;
CREATE SEQUENCE public.seq_id_geral
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1
    NO CYCLE;

CREATE SEQUENCE public.seq_id_item
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1
    NO CYCLE;

CREATE SEQUENCE public.seq_nr_pedido
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    START 1
    CACHE 1
    NO CYCLE;



CREATE OR REPLACE FUNCTION public.gera_log()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
insert
    into
    log(autor, alteracao, nome_tabela, data)
values (user,
TG_OP,
--retorna o tipo de alteração
 TG_RELNAME,
--retorna o nome da tabela
 now());
return new;
end;

$function$
;


CREATE OR REPLACE FUNCTION public.func_grava_dt_atz()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$ 
BEGIN 
    NEW.DT_ATZ = clock_timestamp(); 
    RETURN NEW; 
END;
$function$
;

CREATE OR REPLACE FUNCTION public.func_id_geral()
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
            DECLARE
              RESULTADO BIGINT;
            BEGIN
                /*Gera o id_geral */
                SELECT NEXTVAL(PG_CLASS.OID)
                INTO RESULTADO
                FROM PG_CLASS
                WHERE RELNAME = 'seq_id_geral';
            RETURN RESULTADO + 1000000000000;
            END
            $function$
;


CREATE OR REPLACE FUNCTION public.func_id_item()
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
            DECLARE
              id_item BIGINT;
            BEGIN
                /*Gera o id_item */
                SELECT NEXTVAL(PG_CLASS.OID)
                INTO id_item
                FROM PG_CLASS
                WHERE RELNAME = 'seq_id_item';
            RETURN id_item;
            END
            $function$
;

CREATE OR REPLACE FUNCTION public.func_nr_pedido()
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
            DECLARE
              RESULTADO BIGINT;
            BEGIN
                /*Gera o nr_pedido */
                SELECT NEXTVAL(PG_CLASS.OID)
                INTO RESULTADO
                FROM PG_CLASS
                WHERE RELNAME = 'seq_nr_pedido';
            RETURN RESULTADO;
            END
            $function$
;