-- Criando e utilizando a database que vai conter as tabelas
CREATE DATABASE agriculture_data_management;
USE agriculture_data_management;


CREATE TABLE genero(
    codigo_genero INT AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    
    CONSTRAINT genero_pk
        PRIMARY KEY(codigo_genero),
    CONSTRAINT genero_descricao_uq
        UNIQUE(descricao)
);

INSERT INTO genero(descricao)
VALUES ('MASCULINO'),
       ('FEMININO'),
       ('OUTRO'),
       ('PREFIRO NÃO INFORMAR');

CREATE TABLE pessoa(
    cpf VARCHAR(11) NOT NULL,
    nome VARCHAR(50) NOT NULL,
    nome_mae VARCHAR(50) NOT NULL,
    apelido VARCHAR(20),
    data_nascimento DATE NOT NULL,
    rg VARCHAR(11) NOT NULL,
    uf_orgao_emissor CHAR(2) NOT NULL,
    nis VARCHAR(11) NOT NULL,
    municipio_nascimento VARCHAR(50) NOT NULL,
    escolaridade VARCHAR(50) NOT NULL,
    codigo_genero INT NOT NULL,
    
    CONSTRAINT pessoa_cpf_pk
        PRIMARY KEY(cpf),
    CONSTRAINT pessoa_rg_uq
        UNIQUE(rg),
    CONSTRAINT pessoa_nis_uq
        UNIQUE(nis),
    CONSTRAINT pessoa_cod_genero_fk
        FOREIGN KEY(codigo_genero)
            REFERENCES genero(codigo_genero)
);

CREATE TABLE setor(
    codigo_setor INT AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    
    CONSTRAINT setor_pk
        PRIMARY KEY(codigo_setor),
    CONSTRAINT setor_descricao_uq
        UNIQUE(descricao)
);

INSERT INTO setor(descricao)
VALUES ('AGRICULTURA'),
       ('EQUIPAMENTO'),
       ('CAPACITAÇÃO/ASSISTENCIA TÉCNICA'),
       ('OUTRO');

CREATE TABLE tecnico_responsavel(
    codigo_tecnico_responsavel INT AUTO_INCREMENT,
    cpf VARCHAR(11) NOT NULL,
    codigo_setor INT NOT NULL,
    nome_filial VARCHAR(50),
    
    CONSTRAINT tecnico_responsavel_pk
        PRIMARY KEY(codigo_tecnico_responsavel),
    CONSTRAINT tec_resp_cpf_fk
        FOREIGN KEY(cpf)
            REFERENCES pessoa(cpf),
    CONSTRAINT tec_resp_cod_setor_fk
        FOREIGN KEY(codigo_setor)
            REFERENCES setor(codigo_setor)
);

CREATE TABLE condicao_posse_uso_terra(
    codigo_condicao_posse_uso_terra INT AUTO_INCREMENT,
    descricao VARCHAR(50) NOT NULL,
    
    CONSTRAINT cput_pk
        PRIMARY KEY(codigo_condicao_posse_uso_terra),
    CONSTRAINT cput_descricao_uq
        UNIQUE(descricao)
);

INSERT INTO condicao_posse_uso_terra(descricao)
VALUES ('PROPRIETÁRIO(A)'),
       ('ARRENDATÁRIO(A)'),
       ('POSSEIRO(A)'),
       ('MEEIRO(A)'),
       ('ASSENTADO'),
       ('ACAMPAMENTO');

CREATE TABLE agricultor(
    codigo_agricultor INT AUTO_INCREMENT,
    codigo_condicao_posse_uso_terra INT NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    estado_civil VARCHAR(20),
    quantidade_familiares_residentes INT NOT NULL,
    
    CONSTRAINT agricultor_pk
        PRIMARY KEY(codigo_agricultor),
    CONSTRAINT agricultor_cod_cput_fk
        FOREIGN KEY(codigo_condicao_posse_uso_terra)
            REFERENCES condicao_posse_uso_terra(codigo_condicao_posse_uso_terra),
    CONSTRAINT agricultor_cpf_fk
        FOREIGN KEY(cpf)
            REFERENCES pessoa(cpf)
);

CREATE TABLE agricultor_log(
    log_id INT AUTO_INCREMENT,
    codigo_agricultor INT NOT NULL,
    campo_afetado VARCHAR(50),
    valor_antigo VARCHAR(50),
    valor_novo VARCHAR(50),
    data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT log_id_pk
        PRIMARY KEY(log_id),
    CONSTRAINT log_cod_agricultor_fk
        FOREIGN KEY(codigo_agricultor)
            REFERENCES agricultor(codigo_agricultor)
);

CREATE TABLE conjuge(
    codigo_conjuge INT AUTO_INCREMENT,
    cpf VARCHAR(11) NOT NULL,
    codigo_agricultor INT NOT NULL,
    
    CONSTRAINT conjuge_pk
        PRIMARY KEY(codigo_conjuge),
    CONSTRAINT conjuge_cpf_fk
        FOREIGN KEY(cpf)
            REFERENCES pessoa(cpf),
    CONSTRAINT conjuge_cod_agricultor_fk
        FOREIGN KEY(codigo_agricultor)
            REFERENCES agricultor(codigo_agricultor)
);

CREATE TABLE contato(
    codigo_contato INT AUTO_INCREMENT,
    codigo_agricultor INT NOT NULL,
    numero VARCHAR(20) NOT NULL,
    
    CONSTRAINT contato_pk
        PRIMARY KEY (codigo_contato),
    CONSTRAINT contato_numero_uq
        UNIQUE (numero),
    CONSTRAINT contato_cod_agricultor_fk
        FOREIGN KEY (codigo_agricultor)
            REFERENCES agricultor (codigo_agricultor)
);


CREATE TABLE endereco(
    codigo_endereco INT AUTO_INCREMENT,
    codigo_agricultor INT NOT NULL,
    local_residencia VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    rua VARCHAR(50) NOT NULL,
    numero VARCHAR(10),
    comunidade VARCHAR(50),
    cep VARCHAR(10),
    UF CHAR(2),
    
    CONSTRAINT endereco_pk
        PRIMARY KEY (codigo_endereco),
    CONSTRAINT endereco_cod_agricultor_fk
        FOREIGN KEY (codigo_agricultor)
            REFERENCES agricultor (codigo_agricultor)
);


CREATE TABLE organizacao_social_pertencente(
    codigo_organizacao_social_pertencente INT AUTO_INCREMENT,
    descricao VARCHAR(20) NOT NULL,
    
    CONSTRAINT osp_pk
        PRIMARY KEY(codigo_organizacao_social_pertencente),
    CONSTRAINT osp_descricao_uq
        UNIQUE(descricao)
);


INSERT INTO organizacao_social_pertencente(descricao)
VALUES ('STR/SIND.AGR.FAM'),
       ('COOPERATIVA'),
       ('ASSOCIAÇÃO'),
       ('OUTRA');


CREATE TABLE agricultor_organizacao_social_pertencente (
    codigo_agricultor_organizacao_social_pertencente INT AUTO_INCREMENT,
    codigo_agricultor INT NOT NULL,
    codigo_organizacao_social_pertencente INT NOT NULL,
    
    CONSTRAINT aosp_pk
        PRIMARY KEY (codigo_agricultor_organizacao_social_pertencente),
    CONSTRAINT aosp_cod_agricultor_fk
        FOREIGN KEY (codigo_agricultor)
            REFERENCES agricultor (codigo_agricultor),
    CONSTRAINT aosp_cod_osp_fk
        FOREIGN KEY (codigo_organizacao_social_pertencente)
            REFERENCES organizacao_social_pertencente (codigo_organizacao_social_pertencente)
);


CREATE TABLE atividade_principal(
    codigo_atividade_principal INT AUTO_INCREMENT,
    descricao VARCHAR(20) NOT NULL,
    
    CONSTRAINT ap_pk
        PRIMARY KEY(codigo_atividade_principal),
    CONSTRAINT ap_descricao_uq
        UNIQUE(descricao)
);


INSERT INTO atividade_principal(descricao)
VALUES ('AGRICULTOR(A)'),
       ('PESCADOR(A)'),
       ('OUTRA');


CREATE TABLE agricultor_atividade_principal(
    codigo_agricultor_atividade_principal INT AUTO_INCREMENT,
    codigo_agricultor INT NOT NULL,
    codigo_atividade_principal INT NOT NULL,
    
    CONSTRAINT aap_pk
        PRIMARY KEY (codigo_agricultor_atividade_principal),
    CONSTRAINT aap_cod_agricultor_fk
        FOREIGN KEY (codigo_agricultor)
            REFERENCES agricultor (codigo_agricultor),
    CONSTRAINT aap_cod_ap_fk
        FOREIGN KEY (codigo_atividade_principal)
            REFERENCES atividade_principal(codigo_atividade_principal)
);


CREATE TABLE imovel(
    codigo_imovel INT AUTO_INCREMENT,
    denominacao_imovel VARCHAR(100) NOT NULL,
    area VARCHAR(20) NOT NULL,
    observacoes VARCHAR(255),
    codigo_agricultor INT NOT NULL,
    
    CONSTRAINT imovel_pk
        PRIMARY KEY (codigo_imovel),
    CONSTRAINT imovel_cod_agricultor_fk
        FOREIGN KEY (codigo_agricultor)
            REFERENCES agricultor(codigo_agricultor)
);


CREATE TABLE produto(
    codigo_produto INT AUTO_INCREMENT,
    codigo_imovel INT NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    area VARCHAR(20) NOT NULL,
    unidade INT NOT NULL,
    volume VARCHAR(10) NOT NULL,
    periodicidade VARCHAR(50) NOT NULL,
    
    CONSTRAINT produto_pk
        PRIMARY KEY (codigo_produto),
    CONSTRAINT produto_cod_imovel_fk
        FOREIGN KEY (codigo_imovel)
            REFERENCES imovel(codigo_imovel)
);


CREATE TABLE demanda(
    codigo_demanda INT AUTO_INCREMENT,
    codigo_imovel INT NOT NULL,
    codigo_tecnico_responsavel INT NOT NULL,
    descricao_infraestrutura VARCHAR(255) NOT NULL,
    descricao_capacitacao_assistencia_tecnica VARCHAR(255) NOT NULL,
    data_demanda DATE NOT NULL,
    
    CONSTRAINT demanda_pk
        PRIMARY KEY (codigo_demanda),
    CONSTRAINT demanda_cod_imovel_fk
        FOREIGN KEY (codigo_imovel)
            REFERENCES imovel(codigo_imovel),
    CONSTRAINT demanda_cod_tr_fk
        FOREIGN KEY (codigo_tecnico_responsavel)
            REFERENCES tecnico_responsavel(codigo_tecnico_responsavel)
);