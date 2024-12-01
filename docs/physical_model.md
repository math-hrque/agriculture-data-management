CREATE DATABASE agriculture\_data\_management;  
USE agriculture\_data\_management;

CREATE TABLE genero(  
    codigo\_genero INT AUTO\_INCREMENT,  
    descricao VARCHAR(30) NOT NULL,

    CONSTRAINT genero\_pk PRIMARY KEY(codigo\_genero),  
    CONSTRAINT genero\_descricao\_uq UNIQUE(descricao)  
);

INSERT INTO genero(descricao)  
VALUES ('MASCULINO'),  
       ('FEMININO'),  
       ('OUTRO'),  
       ('PREFIRO NÃO INFORMAR');

CREATE TABLE pessoa(  
    cpf VARCHAR(11) NOT NULL,  
    nome VARCHAR(50) NOT NULL,  
    nome\_mae VARCHAR(50) NOT NULL,  
    apelido VARCHAR(20),  
    data\_nascimento DATE NOT NULL,  
    rg VARCHAR(11) NOT NULL,  
    uf\_orgao\_emissor CHAR(2) NOT NULL,  
    nis VARCHAR(11) NOT NULL,  
    municipio\_nascimento VARCHAR(50) NOT NULL,  
    escolaridade VARCHAR(50) NOT NULL,  
    codigo\_genero INT NOT NULL,

    CONSTRAINT pessoa\_cpf\_pk PRIMARY KEY(cpf),  
    CONSTRAINT pessoa\_rg\_uq UNIQUE(rg),  
    CONSTRAINT pessoa\_nis\_uq UNIQUE(nis),  
    CONSTRAINT pessoa\_cod\_genero\_fk FOREIGN KEY(codigo\_genero) REFERENCES genero(codigo\_genero)  
);

CREATE TABLE setor(  
    codigo\_setor INT AUTO\_INCREMENT,  
    descricao VARCHAR(50) NOT NULL,

    CONSTRAINT setor\_pk PRIMARY KEY(codigo\_setor),  
    CONSTRAINT setor\_descricao\_uq UNIQUE(descricao)  
);

INSERT INTO setor(descricao)  
VALUES ('AGRICULTURA'),  
       ('EQUIPAMENTO'),  
       ('CAPACITAÇÃO/ASSISTENCIA TÉCNICA'),  
       ('OUTRO');

CREATE TABLE tecnico\_responsavel(  
    codigo\_tecnico\_responsavel INT AUTO\_INCREMENT,  
    cpf VARCHAR(11) NOT NULL,  
    codigo\_setor INT NOT NULL,  
    nome\_filial VARCHAR(50),

    CONSTRAINT tecnico\_responsavel\_pk PRIMARY KEY(codigo\_tecnico\_responsavel),  
    CONSTRAINT tec\_resp\_cpf\_fk FOREIGN KEY(cpf) REFERENCES pessoa(cpf),  
    CONSTRAINT tec\_resp\_cod\_setor\_fk FOREIGN KEY(codigo\_setor) REFERENCES setor(codigo\_setor)  
);

CREATE TABLE condicao\_posse\_uso\_terra(  
    codigo\_condicao\_posse\_uso\_terra INT AUTO\_INCREMENT,  
    descricao VARCHAR(50) NOT NULL,

    CONSTRAINT cput\_pk PRIMARY KEY(codigo\_condicao\_posse\_uso\_terra),  
    CONSTRAINT cput\_descricao\_uq UNIQUE(descricao)  
);

INSERT INTO condicao\_posse\_uso\_terra(descricao)  
VALUES ('PROPRIETÁRIO(A)'),  
       ('ARRENDATÁRIO(A)'),  
       ('POSSEIRO(A)'),  
       ('MEEIRO(A)'),  
       ('ASSENTADO'),  
       ('ACAMPAMENTO');

CREATE TABLE agricultor(  
    codigo\_agricultor INT AUTO\_INCREMENT,  
    codigo\_condicao\_posse\_uso\_terra INT NOT NULL,  
    cpf VARCHAR(11) NOT NULL,  
    estado\_civil VARCHAR(20),  
    quantidade\_familiares\_residentes INT NOT NULL,

    CONSTRAINT agricultor\_pk PRIMARY KEY(codigo\_agricultor),  
    CONSTRAINT agricultor\_cod\_cput\_fk FOREIGN KEY(codigo\_condicao\_posse\_uso\_terra) REFERENCES condicao\_posse\_uso\_terra(codigo\_condicao\_posse\_uso\_terra),  
    CONSTRAINT agricultor\_cpf\_fk FOREIGN KEY(cpf) REFERENCES pessoa(cpf)  
);

CREATE TABLE agricultor\_log(  
    log\_id INT AUTO\_INCREMENT,  
    codigo\_agricultor INT NOT NULL,  
    campo\_afetado VARCHAR(50),  
    valor\_antigo VARCHAR(50),  
    valor\_novo VARCHAR(50),  
    data\_atualizacao TIMESTAMP DEFAULT CURRENT\_TIMESTAMP,

    CONSTRAINT log\_id\_pk PRIMARY KEY(log\_id),  
    CONSTRAINT log\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor)  
);

CREATE TABLE conjuge(  
    codigo\_conjuge INT AUTO\_INCREMENT,  
    cpf VARCHAR(11) NOT NULL,  
    codigo\_agricultor INT NOT NULL,

    CONSTRAINT conjuge\_pk PRIMARY KEY(codigo\_conjuge),  
    CONSTRAINT conjuge\_cpf\_fk FOREIGN KEY(cpf) REFERENCES pessoa(cpf),  
    CONSTRAINT conjuge\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor)  
);

CREATE TABLE contato(  
    codigo\_contato INT AUTO\_INCREMENT,  
    codigo\_agricultor INT NOT NULL,  
    numero VARCHAR(20) NOT NULL,

    CONSTRAINT contato\_pk PRIMARY KEY(codigo\_contato),  
    CONSTRAINT contato\_numero\_uq UNIQUE(numero),  
    CONSTRAINT contato\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor)  
);

CREATE TABLE endereco(  
    codigo\_endereco INT AUTO\_INCREMENT,  
    codigo\_agricultor INT NOT NULL,  
    local\_residencia VARCHAR(50) NOT NULL,  
    cidade VARCHAR(50) NOT NULL,  
    rua VARCHAR(50) NOT NULL,  
    numero VARCHAR(10),  
    comunidade VARCHAR(50),  
    cep VARCHAR(10),  
    UF CHAR(2),

    CONSTRAINT endereco\_pk PRIMARY KEY(codigo\_endereco),  
    CONSTRAINT endereco\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor)  
);

CREATE TABLE organizacao\_social\_pertencente(  
    codigo\_organizacao\_social\_pertencente INT AUTO\_INCREMENT,  
    descricao VARCHAR(20) NOT NULL,

    CONSTRAINT osp\_pk PRIMARY KEY(codigo\_organizacao\_social\_pertencente),  
    CONSTRAINT osp\_descricao\_uq UNIQUE(descricao)  
);

INSERT INTO organizacao\_social\_pertencente(descricao)  
VALUES ('STR/SIND.AGR.FAM'),  
       ('COOPERATIVA'),  
       ('ASSOCIAÇÃO'),  
       ('OUTRA');

CREATE TABLE atividade\_principal(  
    codigo\_atividade\_principal INT AUTO\_INCREMENT,  
    descricao VARCHAR(20) NOT NULL,

    CONSTRAINT ap\_pk PRIMARY KEY(codigo\_atividade\_principal),  
    CONSTRAINT ap\_descricao\_uq UNIQUE(descricao)  
);

CREATE TABLE agricultor\_organizacao\_social\_pertencente (  
    codigo\_agricultor\_organizacao\_social\_pertencente INT AUTO\_INCREMENT,  
    codigo\_agricultor INT NOT NULL,  
    codigo\_organizacao\_social\_pertencente INT NOT NULL,

    CONSTRAINT aosp\_pk PRIMARY KEY(codigo\_agricultor\_organizacao\_social\_pertencente),  
    CONSTRAINT aosp\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor),  
    CONSTRAINT aosp\_cod\_osp\_fk FOREIGN KEY(codigo\_organizacao\_social\_pertencente) REFERENCES organizacao\_social\_pertencente(codigo\_organizacao\_social\_pertencente)  
);

INSERT INTO atividade\_principal(descricao)  
VALUES ('AGRICULTOR(A)'),  
       ('PESCADOR(A)'),  
       ('OUTRA');

CREATE TABLE agricultor\_atividade\_principal(  
    codigo\_agricultor\_atividade\_principal INT AUTO\_INCREMENT,  
    codigo\_agricultor INT NOT NULL,  
    codigo\_atividade\_principal INT NOT NULL,

    CONSTRAINT aap\_pk PRIMARY KEY(codigo\_agricultor\_atividade\_principal),  
    CONSTRAINT aap\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor),  
    CONSTRAINT aap\_cod\_ap\_fk FOREIGN KEY(codigo\_atividade\_principal) REFERENCES atividade\_principal(codigo\_atividade\_principal)  
);

CREATE TABLE imovel(  
    codigo\_imovel INT AUTO\_INCREMENT,  
    denominacao\_imovel VARCHAR(100) NOT NULL,  
    area VARCHAR(20) NOT NULL,  
    observacoes VARCHAR(255),  
    codigo\_agricultor INT NOT NULL,

    CONSTRAINT imovel\_pk PRIMARY KEY(codigo\_imovel),  
    CONSTRAINT imovel\_cod\_agricultor\_fk FOREIGN KEY(codigo\_agricultor) REFERENCES agricultor(codigo\_agricultor)  
);

CREATE TABLE produto(  
    codigo\_produto INT AUTO\_INCREMENT,  
    codigo\_imovel INT NOT NULL,  
    descricao VARCHAR(50) NOT NULL,  
    area VARCHAR(20) NOT NULL,  
    unidade INT NOT NULL,  
    volume VARCHAR(10) NOT NULL,  
    periodicidade VARCHAR(50) NOT NULL,

    CONSTRAINT produto\_pk PRIMARY KEY(codigo\_produto),  
    CONSTRAINT produto\_cod\_imovel\_fk FOREIGN KEY(codigo\_imovel) REFERENCES imovel(codigo\_imovel)  
);

CREATE TABLE demanda(  
    codigo\_demanda INT AUTO\_INCREMENT,  
    codigo\_imovel INT NOT NULL,  
    codigo\_tecnico\_responsavel INT NOT NULL,  
    descricao\_infraestrutura VARCHAR(255) NOT NULL,  
    descricao\_capacitacao\_assistencia\_tecnica VARCHAR(255) NOT NULL,  
    data\_demanda DATE NOT NULL,

    CONSTRAINT demanda\_pk PRIMARY KEY(codigo\_demanda),  
    CONSTRAINT demanda\_cod\_imovel\_fk FOREIGN KEY(codigo\_imovel) REFERENCES imovel(codigo\_imovel),  
    CONSTRAINT demanda\_cod\_tr\_fk FOREIGN KEY(codigo\_tecnico\_responsavel) REFERENCES tecnico\_responsavel(codigo\_tecnico\_responsavel)  
);