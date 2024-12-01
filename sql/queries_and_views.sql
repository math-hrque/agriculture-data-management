--Puxar informações pessoais de 100 agricultores
SELECT
    nome,
    nome_mae,
    apelido,
    data_nascimento,
    municipio_nascimento,
    escolaridade,
    g.descricao AS descricao_genero,
    cpf,
    estado_civil,
    quantidade_familiares_residentes
FROM agricultor
LEFT JOIN pessoa USING(cpf)
LEFT JOIN genero g USING(codigo_genero)
LIMIT 100;

--Criar View com as informações de agricultores e imoveis
CREATE VIEW vw_agricultores_e_imoveis AS
SELECT
    codigo_agricultor,
    codigo_condicao_posse_uso_terra,
    estado_civil,
    quantidade_familiares_residentes,
    c.descricao AS descricao_condicao_posse,
    i.denominacao_imovel,
    i.area AS area_imovel,
    i.observacoes AS observacoes_imovel
FROM agricultor a
LEFT JOIN condicao_posse_uso_terra c USING (codigo_condicao_posse_uso_terra)
LEFT JOIN imovel i USING (codigo_agricultor);

--Puxar informações da view com alguns filtros
SELECT *
FROM vw_agricultores_e_imoveis
WHERE area_imovel = '85 hectares'
AND descricao_condicao_posse = 'PROPRIETÁRIO(A)'
AND quantidade_familiares_residentes <= 5;

--Puxar informações do agricultor com id 3456
SELECT * 
FROM agricultor
LEFT JOIN condicao_posse_uso_terra c USING (codigo_condicao_posse_uso_terra)
WHERE codigo_agricultor = 3456;

--Atualizar dados do agricultor 3456
UPDATE agricultor
SET
    quantidade_familiares_residentes = 3,
    codigo_condicao_posse_uso_terra = 1
WHERE codigo_agricultor = 3456;

--Verificar atualização na tabela agricultor
SELECT * 
FROM agricultor
LEFT JOIN condicao_posse_uso_terra c USING (codigo_condicao_posse_uso_terra)
WHERE codigo_agricultor = 3456;

--Verificar atualização na tabela de logs do agricultor
SELECT *
FROM agricultor_log;


-- Relatório das 50 demandas mais recentes por infraestrutura e capacitação técnica
SELECT
    d.codigo_demanda,
    i.denominacao_imovel,
    i.area AS area_imovel,
    d.descricao_infraestrutura,
    d.descricao_capacitacao_assistencia_tecnica,
    d.data_demanda,
    t.cpf AS tecnico_cpf,
    p.nome AS tecnico_nome,
    s.descricao AS setor_descricao
FROM demanda d
LEFT JOIN imovel i USING(codigo_imovel)
LEFT JOIN tecnico_responsavel t USING(codigo_tecnico_responsavel)
LEFT JOIN pessoa p ON t.cpf = p.cpf
LEFT JOIN setor s USING(codigo_setor)
ORDER BY d.data_demanda DESC
LIMIT 50;

-- Relatório dos 50 primeiros agricultores em ordem alfabética e suas atividades principais
SELECT
    a.codigo_agricultor,
    p.nome AS agricultor_nome,
    p.cpf AS agricultor_cpf,
    p.data_nascimento,
    ap.descricao AS atividade_principal,
    osp.descricao AS organizacao_social
FROM agricultor a
LEFT JOIN pessoa p USING(cpf)
LEFT JOIN agricultor_atividade_principal aap ON a.codigo_agricultor = aap.codigo_agricultor
LEFT JOIN atividade_principal ap ON aap.codigo_atividade_principal = ap.codigo_atividade_principal
LEFT JOIN agricultor_organizacao_social_pertencente aosp ON a.codigo_agricultor = aosp.codigo_agricultor
LEFT JOIN organizacao_social_pertencente osp ON aosp.codigo_organizacao_social_pertencente = osp.codigo_organizacao_social_pertencente
ORDER BY p.nome
LIMIT 50;



