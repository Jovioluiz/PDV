CREATE TABLE public.log (
	autor varchar(20) NULL,
	alteracao varchar(10) NULL,
	nome_tabela varchar(50) NULL,
	"data" timestamp NULL
);

CREATE TABLE pais (
  cd_pais int NOT NULL,
  nm_pais varchar(50) DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_pais PRIMARY KEY (cd_pais)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.pais for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.pais for each row execute procedure gera_log();

CREATE TABLE estado (
  uf varchar(2) NOT NULL,
  nm_uf varchar(40) DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_uf PRIMARY KEY (uf)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.estado for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.estado for each row execute procedure gera_log();

CREATE TABLE cidade (
  cd_cidade int NOT NULL,
  nm_cidade varchar(40) NOT NULL,
  uf varchar(2) NOT NULL,
  cep varchar(8) DEFAULT NULL,
  cd_ibge int DEFAULT NULL,
  cd_pais int DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_cidade PRIMARY KEY (cd_cidade),
  CONSTRAINT fk_cidade_cd_pais FOREIGN KEY (cd_pais) REFERENCES pais (cd_pais),
  CONSTRAINT fk_cidade_estado FOREIGN KEY (uf) REFERENCES estado (uf)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.cidade for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.cidade for each row execute procedure gera_log();

CREATE TABLE bairro (
  cd_bairro int NOT NULL,
  cd_cidade int NOT NULL,
  descricao_bairro varchar(72) DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_bairro PRIMARY KEY (cd_bairro),
  CONSTRAINT fk_bairro_cidade FOREIGN KEY (cd_cidade) REFERENCES cidade (cd_cidade) ON DELETE CASCADE
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.bairro for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.bairro for each row execute procedure gera_log();

CREATE TABLE endereco (
  cd_endereco int NOT NULL,
  cd_bairro int NOT NULL,
  endereco_cep varchar(9) NOT NULL,
  endereco_logradouro varchar(100) DEFAULT NULL,
  endereco_complemento varchar(100) DEFAULT NULL,
  dt_atz timestamp DEFAULT now(),
  constraint pk_enderec PRIMARY KEY (cd_endereco),
  CONSTRAINT fk_endereco_bairro FOREIGN KEY (cd_bairro) REFERENCES bairro (cd_bairro) ON DELETE CASCADE
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.endereco for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.endereco for each row execute procedure gera_log();

CREATE TABLE fornecedor (
  cd_fornecedor int NOT NULL,
  tp_pessoa varchar(2) NOT NULL,
  nm_fornecedor varchar(25) NOT NULL,
  cpf_cnpj varchar(15) NOT NULL,
  rg_ie varchar(20) NOT NULL,
  telefone varchar(15) DEFAULT NULL,
  logradouro varchar(50) NOT NULL,
  numero varchar (10) DEFAULT NULL,
  bairro varchar(50) NOT NULL,
  cidade varchar(50) NOT NULL,
  uf varchar(2) NOT NULL,
  cep varchar(10) DEFAULT NULL,
  tipo_produto varchar(50) DEFAULT NULL,
  data_cadastro date DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_fornecedor PRIMARY KEY (cd_fornecedor)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.fornecedor for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.fornecedor for each row execute procedure gera_log();

CREATE TABLE produtos (
  id_item int NOT NULL,
  cd_item varchar(60) not null,
  nm_produto varchar(60),
  descricao varchar(100),
  valor numeric(15,4),
  qtd_estoque numeric(15,4) DEFAULT '0.0000',
  un_medida varchar(5),
  fator_conversao numeric(4,2),
  data_cadastro date,
  imagem bytea,
  data_ult_compra date,
  dt_atz timestamp,
  constraint pk_produtos PRIMARY KEY (id_item)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.produtos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.produtos for each row execute procedure gera_log();

CREATE TABLE produtos_cod_barras(
  id_geral int8 not null,   
  id_item int not null,
  codigo_barras varchar(50),
  dt_atz timestamp,
constraint pk_produtos_cod_barras PRIMARY KEY (id_geral),
constraint fl_produtos_cod_barras_produtos foreign key (id_item) REFERENCES produtos(id_item)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.produtos_cod_barras for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.produtos_cod_barras for each row execute procedure gera_log();

CREATE TABLE entrada_produtos (
  id_geral int8 NOT NULL,
  id_item int NOT NULL,
  qtdade numeric(12,4),
  cd_fornecedor int NOT NULL,
  vl_unitario numeric(12,4),
  vl_total numeric(12,4),
  data_entrada date,
  un_compra varchar(5),
  dt_atz timestamp,
  constraint pk_entrada_produtos PRIMARY KEY (id_geral),
  CONSTRAINT fk_entrada_produtos_fornecedor FOREIGN KEY (cd_fornecedor) REFERENCES fornecedor (cd_fornecedor),
  CONSTRAINT fk_produto FOREIGN KEY (id_item) REFERENCES produtos (id_item)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.entrada_produtos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.entrada_produtos for each row execute procedure gera_log();


CREATE TABLE cargos (
  cd_cargo int,
  nm_cargo varchar(25),
  dt_atz timestamp,
  constraint pk_cargos PRIMARY KEY (cd_cargo)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.cargos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.cargos for each row execute procedure gera_log();

CREATE TABLE funcionarios (
  cd_funcionario int,
  cd_cargo int NOT NULL,
  nm_funcionario varchar(25) NOT NULL,
  cpf varchar(15) NOT NULL,
  rg varchar(20),
  telefone varchar(15),
  logradouro varchar(50),
  numero varchar(10),
  bairro varchar(50) NOT NULL,
  cidade varchar(50) NOT NULL,
  uf varchar(2) NOT NULL,
  cep varchar(10),
  data_cadastro date,
  dt_atz timestamp,
  constraint pk_funcionarios PRIMARY KEY (cd_funcionario),
  constraint fk_funcionarios_cargos foreign key (cd_cargo) REFERENCES cargos(cd_cargo)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.funcionarios for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.funcionarios for each row execute procedure gera_log();

CREATE TABLE usuarios (
  cd_usuario int NOT NULL,
  nm_usuario varchar(100) not null,
  senha varchar(25) NOT NULL,
  cd_funcionario int NOT NULL,
  dt_atz timestamp,
  constraint pk_usuarios PRIMARY KEY (cd_usuario),
  constraint fk_usuarios_funcionarios foreign KEY (cd_funcionario) REFERENCES funcionarios(cd_funcionario)
); 
create trigger tr_dt_atz before
insert
    or
update
    on
    public.usuarios for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.usuarios for each row execute procedure gera_log();

CREATE TABLE saidas_produtos (
  id_geral int8 NOT NULL,
  id_item int NOT NULL,
  qtdade numeric(12,4) DEFAULT NULL,
  un_saida varchar(5) DEFAULT NULL,
  motivo varchar(50) NOT NULL,
  data_saida date DEFAULT NULL,
  dt_atz timestamp,
  CONSTRAINT pk_saidas_produtos PRIMARY KEY (id_geral),
  CONSTRAINT fk_saida_produtos_produtos FOREIGN KEY (id_item) REFERENCES produtos (id_item)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.saidas_produtos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.saidas_produtos for each row execute procedure gera_log();

CREATE TABLE vendas (
  id_geral int8 NOT NULL,
  nr_venda int not null,
  cd_funcionario int NOT NULL,
  data_venda date,
  vl_troco numeric(12,4),
  vl_total numeric(12,4),
  vl_desconto numeric(12,4),
  vl_acrescimo numeric(12,4),
  vl_recebido numeric(12,4),
  status varchar(5),
  dt_atz timestamp,
  constraint pk_vendas PRIMARY KEY (id_geral),
  CONSTRAINT fk_venda_funcionario FOREIGN KEY (cd_funcionario) REFERENCES funcionarios (cd_funcionario)
);
comment on column vendas.status is 'C - Concluido  / CA - Cancelado';
create trigger tr_dt_atz before
insert
    or
update
    on
    public.vendas for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.vendas for each row execute procedure gera_log();

CREATE TABLE detalhes_vendas (
  id_geral int8 NOT NULL,
  id_vendas int8 NOT NULL,
  id_item int NOT NULL,
  vl_unitario numeric(12,4),
  qt_venda numeric(10,2),
  vl_total numeric(12,4),
  dt_atz timestamp,
  constraint pk_detalhes_vendas PRIMARY KEY (id_geral),
  constraint fl_detalhes_vendas_vendas foreign key (id_vendas) REFERENCES vendas(id_geral),
  CONSTRAINT fk_detalhes_vendas_produtos FOREIGN KEY (id_item) REFERENCES produtos (id_item)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.detalhes_vendas for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.detalhes_vendas for each row execute procedure gera_log();

CREATE TABLE gastos (
  id_geral int8 NOT NULL,
  motivo varchar(50) NOT NULL,
  vl_gasto numeric(12,4) NOT NULL,
  cd_funcionario int DEFAULT NULL,
  dt_gasto date,
  dt_atz timestamp,
  CONSTRAINT pk_gastos PRIMARY KEY (id_geral),
  CONSTRAINT fk_gastos_funcionarios FOREIGN KEY (cd_funcionario) REFERENCES funcionarios (cd_funcionario)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.gastos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.gastos for each row execute procedure gera_log();

CREATE TABLE movimentacoes (
  id_geral int8 NOT NULL,
  fl_entrada_saida varchar(5) NOT NULL,
  tp_movimento varchar(5) NOT NULL,
  vl_movimento numeric(12,4) DEFAULT NULL,
  cd_funcionario int not NULL,
  data date,
  id_venda int8 not null,
  id_movimento_gasto int8 null,
  dt_atz timestamp,
  constraint pk_movimentacoes PRIMARY KEY (id_geral),
  CONSTRAINT fk_movimentacoes_funcionarios FOREIGN KEY (cd_funcionario) REFERENCES funcionarios (cd_funcionario),
  CONSTRAINT fk_movimentacoes_vendas FOREIGN KEY (id_venda) REFERENCES vendas (id_geral),
  CONSTRAINT fk_movimentacoes_gasto FOREIGN KEY (id_movimento_gasto) REFERENCES gastos (id_geral) ON DELETE CASCADE
);
comment on column movimentacoes.fl_entrada_saida is 'E - Entrada / S-Saida';
comment on column movimentacoes.tp_movimento is 'V - Venda / D - despesa';
create trigger tr_dt_atz before
insert
    or
update
    on
    public.movimentacoes for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.movimentacoes for each row execute procedure gera_log();

CREATE TABLE pagamentos (
  id_geral int8 NOT NULL,
  motivo varchar(25) NOT NULL,
  descricao varchar(50) DEFAULT NULL,
  vl_pagamento numeric(12,4) NOT NULL,
  cd_funcionario int DEFAULT NULL,
  data date DEFAULT NULL,
  dt_atz timestamp,
  constraint pk_pagamentos PRIMARY KEY (id_geral),
  CONSTRAINT fk_pagamentos_funcionarios FOREIGN KEY (cd_funcionario) REFERENCES funcionarios (cd_funcionario)
);
create trigger tr_dt_atz before
insert
    or
update
    on
    public.pagamentos for each row execute procedure func_grava_dt_atz();
create trigger tr_gera_log after
insert
    or
delete
    or
update
    on
    public.pagamentos for each row execute procedure gera_log();

ALTER TABLE public.usuarios ADD fl_ativo bool NULL;
ALTER TABLE public.produtos RENAME COLUMN valor TO vl_unitario;
ALTER TABLE public.produtos RENAME COLUMN qtd_estoque TO qt_estoque;
ALTER TABLE public.produtos_cod_barras ADD CONSTRAINT fl_produtos_cod_barras_produtos FOREIGN KEY (id_item) REFERENCES produtos(id_item) on delete cascade;
ALTER TABLE public.detalhes_vendas DROP CONSTRAINT fl_detalhes_vendas_vendas;
ALTER TABLE public.detalhes_vendas ADD CONSTRAINT fk_detalhes_vendas_vendas FOREIGN KEY (id_vendas) REFERENCES vendas(id_geral) on delete cascade;
ALTER TABLE public.detalhes_vendas ADD fl_cancelado bool NULL;
ALTER TABLE public.detalhes_vendas ALTER COLUMN fl_cancelado TYPE varchar(1) USING fl_cancelado::varchar;