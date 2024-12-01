DELIMITER //

CREATE PROCEDURE PopulateDatabase()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE genero_count INT DEFAULT 4;
    DECLARE setor_count INT DEFAULT 4;
    DECLARE condicao_posse_count INT DEFAULT 6;
    DECLARE organizacao_social_count INT DEFAULT 4;
    DECLARE atividade_principal_count INT DEFAULT 3;

    DECLARE tecnico_counter INT DEFAULT 0;
    DECLARE agricultor_counter INT DEFAULT 0;
    DECLARE conjuge_counter INT DEFAULT 0;

    WHILE i <= 10000 DO
        -- Gerar o CPF
        SET @cpf = LPAD(i, 11, '0');

        -- Inserir na tabela pessoa
        INSERT INTO pessoa (cpf, nome, nome_mae, apelido, data_nascimento, rg, uf_orgao_emissor, nis, municipio_nascimento, escolaridade, codigo_genero)
        VALUES (
            @cpf,
            CONCAT('Nome', i),
            CONCAT('NomeMae', i),
            CONCAT('Apelido', i),
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365 * 30) DAY),
            LPAD(i, 11, '0'),
            'SP',
            LPAD(i, 11, '0'),
            CONCAT('Municipio', i),
            FLOOR(RAND() * 10) + 1,
            FLOOR(RAND() * genero_count) + 1
        );

        -- Distribuir CPFs entre tecnico_responsavel, agricultor e conjuge
        IF tecnico_counter < 1000 THEN
            -- Inserir na tabela tecnico_responsavel
            INSERT INTO tecnico_responsavel (cpf, codigo_setor, nome_filial)
            VALUES (
                @cpf,
                FLOOR(RAND() * setor_count) + 1,
                CONCAT('Filial', i)
            );
            SET tecnico_counter = tecnico_counter + 1;
        ELSEIF agricultor_counter < 6000 THEN
            -- Inserir na tabela agricultor
            INSERT INTO agricultor (codigo_condicao_posse_uso_terra, cpf, estado_civil, quantidade_familiares_residentes)
            VALUES (
                FLOOR(RAND() * condicao_posse_count) + 1,
                @cpf,
                'SOLTEIRO(A)',
                FLOOR(RAND() * 10) + 1
            );

            -- Recuperar o código do agricultor inserido
            SET @codigo_agricultor = LAST_INSERT_ID();

            -- Inserir na tabela contato
            INSERT INTO contato (codigo_agricultor, numero)
            VALUES (
                @codigo_agricultor,
                CONCAT('Numero', i)
            );

            -- Inserir na tabela endereco
            INSERT INTO endereco (codigo_agricultor, local_residencia, cidade, rua, numero, comunidade, cep, UF)
            VALUES (
                @codigo_agricultor,
                CONCAT('Residencia', i),
                CONCAT('Cidade', i),
                CONCAT('Rua', i),
                LPAD(i, 10, '0'),
                CONCAT('Comunidade', i),
                LPAD(i, 8, '0'),
                'SP'
            );

            -- Inserir na tabela agricultor_organizacao_social_pertencente
            INSERT INTO agricultor_organizacao_social_pertencente (codigo_agricultor, codigo_organizacao_social_pertencente)
            VALUES (
                @codigo_agricultor,
                FLOOR(RAND() * organizacao_social_count) + 1
            );

            -- Inserir na tabela agricultor_atividade_principal
            INSERT INTO agricultor_atividade_principal (codigo_agricultor, codigo_atividade_principal)
            VALUES (
                @codigo_agricultor,
                FLOOR(RAND() * atividade_principal_count) + 1
            );

            -- Inserir na tabela imovel
            INSERT INTO imovel (denominacao_imovel, area, observacoes, codigo_agricultor)
            VALUES (
                CONCAT('Imovel', i),
                CONCAT(FLOOR(RAND() * 100) + 1, ' hectares'),
                CONCAT('Observacao', i),
                @codigo_agricultor
            );

            -- Recuperar o código do imóvel inserido
            SET @codigo_imovel = LAST_INSERT_ID();

            -- Inserir na tabela produto
            INSERT INTO produto (codigo_imovel, descricao, area, unidade, volume, periodicidade)
            VALUES (
                @codigo_imovel,
                CONCAT('Produto', i),
                CONCAT(FLOOR(RAND() * 100) + 1, ' hectares'),
                FLOOR(RAND() * 10) + 1,
                CONCAT(FLOOR(RAND() * 1000) + 1, ' kg'),
                CONCAT(FLOOR(RAND() * 10) + 1, ' dias')
            );

            -- Inserir na tabela demanda
            INSERT INTO demanda (codigo_imovel, codigo_tecnico_responsavel, descricao_infraestrutura, descricao_capacitacao_assistencia_tecnica, data_demanda)
            VALUES (
                @codigo_imovel,
                FLOOR(RAND() * 1000) + 1, -- Código do técnico responsável (aleatório para simplificação)
                CONCAT('Infraestrutura', i),
                CONCAT('Capacitacao', i),
                DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND() * 365) DAY)
            );

            SET agricultor_counter = agricultor_counter + 1;
        ELSEIF conjuge_counter < 3000 THEN
            -- Selecionar um agricultor aleatório para ser casado
            SET @codigo_agricultor = FLOOR(RAND() * 6000) + 1;

            -- Atualizar o estado civil do agricultor para 'CASADO(A)'
            UPDATE agricultor
            SET estado_civil = 'CASADO(A)'
            WHERE codigo_agricultor = @codigo_agricultor;

            -- Inserir na tabela conjuge
            INSERT INTO conjuge (cpf, codigo_agricultor)
            VALUES (
                @cpf,
                @codigo_agricultor
            );

            SET conjuge_counter = conjuge_counter + 1;
        END IF;

        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

-- Chamando o procedimento
CALL PopulateDatabase();
