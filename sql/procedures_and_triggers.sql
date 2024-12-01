DELIMITER //

CREATE TRIGGER trg_update_agricultor
AFTER UPDATE ON agricultor
FOR EACH ROW
BEGIN
    IF OLD.codigo_condicao_posse_uso_terra <> NEW.codigo_condicao_posse_uso_terra THEN
        INSERT INTO agricultor_log (codigo_agricultor, campo_afetado, valor_antigo, valor_novo)
        VALUES (NEW.codigo_agricultor, 'codigo_condicao_posse_uso_terra', OLD.codigo_condicao_posse_uso_terra, NEW.codigo_condicao_posse_uso_terra);
    END IF;

    IF OLD.estado_civil <> NEW.estado_civil THEN
        INSERT INTO agricultor_log (codigo_agricultor, campo_afetado, valor_antigo, valor_novo)
        VALUES (NEW.codigo_agricultor, 'estado_civil', OLD.estado_civil, NEW.estado_civil);
    END IF;

    IF OLD.quantidade_familiares_residentes <> NEW.quantidade_familiares_residentes THEN
        INSERT INTO agricultor_log (codigo_agricultor, campo_afetado, valor_antigo, valor_novo)
        VALUES (NEW.codigo_agricultor, 'quantidade_familiares_residentes', OLD.quantidade_familiares_residentes, NEW.quantidade_familiares_residentes);
    END IF;
END //

DELIMITER ;