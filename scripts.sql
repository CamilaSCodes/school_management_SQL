/* Creates a view that presents information about students, including their gender, enrollment date, 
enrolled discipline, and the respective professor. It retrieves this information by joining the 
'matriculas' (enrollments), 'disciplinas' (disciplines), 'professores' (professors), and 'alunos' (students) tables. 
Finally, it orders the results by discipline name and student name in descending order. */

CREATE VIEW ver_informacoes AS
SELECT 
	alunos.nm_aluno_al, 
	CASE 
		WHEN alunos.tp_sexo_al ilike 'M' THEN 'Masculino'
		WHEN alunos.tp_sexo_al ilike 'F' THEN 'Feminino'
		ELSE 'Não identificado' 
	END as tp_sexo_al,
	to_char(matriculas.dt_matricula_ma, 'TMDay, DD "de" TMMonth YYYY') AS dt_matricula_ma,
	disciplinas.nm_disciplina_di,
	professores.nm_professor_pr
FROM 
	matriculas 
JOIN 
	disciplinas USING (cd_disciplina_di) 
JOIN 
	professores USING (cd_professor_pr) 
JOIN 
	alunos USING(cd_aluno_al)
ORDER BY 
	disciplinas.nm_disciplina_di, alunos.nm_aluno_al desc; 
	
SELECT * FROM ver_informacoes; 

/* Sets up a mechanism to track changes made to specific fields in the alunos table and log those changes in the logs_usuarios table, 
providing accountability and auditability for data modifications. */

CREATE OR REPLACE FUNCTION criar_logs() 
RETURNS trigger AS
    $$
	BEGIN
	-- Check if the 'nm_aluno_al' field has been changed
	IF (OLD.nm_aluno_al IS NOT null AND NEW.nm_aluno_al IS null) OR (OLD.nm_aluno_al IS null AND NEW.nm_aluno_al IS NOT null) OR (OLD.nm_aluno_al <> NEW.nm_aluno_al) THEN
    	-- Log the operation and values into the 'logs_usuarios' table
		IF (TG_OP = 'INSERT') THEN -- Insert operation
        	INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nm_aluno_al', OLD.nm_aluno_al, NEW.nm_aluno_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN -- Update operation
        	INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nm_aluno_al', OLD.nm_aluno_al, NEW.nm_aluno_al, current_timestamp, current_user);
        ELSE -- Delete operation
        	INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nm_aluno_al', OLD.nm_aluno_al, NEW.nm_aluno_al, current_timestamp, current_user);
        END IF;
    	END IF;
		
	-- Similar checks and logging for other fields
	IF (OLD.dt_nascimento_al IS NOT null AND NEW.dt_nascimento_al IS null) OR (OLD.dt_nascimento_al IS null AND NEW.dt_nascimento_al IS NOT null) OR (OLD.dt_nascimento_al <> NEW.dt_nascimento_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'dt_nascimento_al', OLD.dt_nascimento_al, NEW.dt_nascimento_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'dt_nascimento_al', OLD.dt_nascimento_al, NEW.dt_nascimento_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'dt_nascimento_al', OLD.dt_nascimento_al, NEW.dt_nascimento_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.tp_sexo_al IS NOT null AND NEW.tp_sexo_al IS null) OR (OLD.tp_sexo_al IS null AND NEW.tp_sexo_al IS NOT null) OR (OLD.tp_sexo_al <> NEW.tp_sexo_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'tp_sexo_al', OLD.tp_sexo_al, NEW.tp_sexo_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'tp_sexo_al', OLD.tp_sexo_al, NEW.tp_sexo_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'tp_sexo_al', OLD.tp_sexo_al, NEW.tp_sexo_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
    	IF (OLD.de_endereco_al IS NOT null AND NEW.de_endereco_al IS null) OR (OLD.de_endereco_al IS null AND NEW.de_endereco_al IS NOT null) OR (OLD.de_endereco_al <> NEW.de_endereco_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'de_endereco_al', OLD.de_endereco_al, NEW.de_endereco_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'de_endereco_al', OLD.de_endereco_al, NEW.de_endereco_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'de_endereco_al', OLD.de_endereco_al, NEW.de_endereco_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.nu_endereco_al IS NOT null AND NEW.nu_endereco_al = null) OR (OLD.nu_endereco_al IS null AND NEW.nu_endereco_al IS NOT null) OR (OLD.nu_endereco_al <> NEW.nu_endereco_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nu_endereco_al', OLD.nu_endereco_al, NEW.nu_endereco_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nu_endereco_al', OLD.nu_endereco_al, NEW.nu_endereco_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nu_endereco_al', OLD.nu_endereco_al, NEW.nu_endereco_al, current_timestamp, current_user);
        END IF;
    	END IF;
      
    	IF (OLD.nm_bairro_al IS NOT null AND NEW.nm_bairro_al IS null) OR (OLD.nm_bairro_al IS null AND NEW.nm_bairro_al IS NOT null) OR (OLD.nm_bairro_al <> NEW.nm_bairro_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nm_bairro_al', OLD.nm_bairro_al, NEW.nm_bairro_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nm_bairro_al', OLD.nm_bairro_al, NEW.nm_bairro_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nm_bairro_al', OLD.nm_bairro_al, NEW.nm_bairro_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.nm_cidade_al IS NOT null AND NEW.nm_cidade_al IS null) OR (OLD.nm_cidade_al IS null AND NEW.nm_cidade_al IS NOT null) OR (OLD.nm_cidade_al <> NEW.nm_cidade_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nm_cidade_al', OLD.nm_cidade_al, NEW.nm_cidade_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nm_cidade_al', OLD.nm_cidade_al, NEW.nm_cidade_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nm_cidade_al', OLD.nm_cidade_al, NEW.nm_cidade_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.nu_cep_al IS NOT null AND NEW.nu_cep_al IS null) OR (OLD.nu_cep_al IS null AND NEW.nu_cep_al IS NOT null) OR (OLD.nu_cep_al <> NEW.nu_cep_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nu_cep_al', OLD.nu_cep_al, NEW.nu_cep_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nu_cep_al', OLD.nu_cep_al, NEW.nu_cep_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nu_cep_al', OLD.nu_cep_al, NEW.nu_cep_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.de_email_al IS NOT null AND NEW.de_email_al IS null) OR (OLD.de_email_al IS null AND NEW.de_email_al IS NOT null) OR (OLD.de_email_al <> NEW.de_email_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'de_email_al', OLD.de_email_al, NEW.de_email_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'de_email_al', OLD.de_email_al, NEW.de_email_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'de_email_al', OLD.de_email_al, NEW.de_email_al, current_timestamp, current_user);
        END IF;
    	END IF;
	  
	IF (OLD.nu_telefone_al IS NOT null AND NEW.nu_telefone_al IS null) OR (OLD.nu_telefone_al IS null AND NEW.nu_telefone_al IS NOT null) OR (OLD.nu_telefone_al <> NEW.nu_telefone_al) THEN
        IF (TG_OP = 'INSERT') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nu_telefone_al', OLD.nu_telefone_al, NEW.nu_telefone_al, current_timestamp, current_user);
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nu_telefone_al', OLD.nu_telefone_al, NEW.nu_telefone_al, current_timestamp, current_user);
        ELSE
            INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nu_telefone_al', OLD.nu_telefone_al, NEW.nu_telefone_al, current_timestamp, current_user);
        END IF;
    	END IF;
      
    RETURN NULL;
    END
    $$
  LANGUAGE plpgsql;
  
  -- This trigger is executed after any INSERT, UPDATE, or DELETE operation on the 'alunos' table.
  CREATE TRIGGER criacao_logs
  AFTER INSERT OR UPDATE OR DELETE ON alunos
  FOR EACH ROW
  EXECUTE PROCEDURE criar_logs();

/*  Automates the process of recording changes made to specific fields in the disciplinas table 
and manages the enrollment process for students in those disciplines by creating entries in the matriculas table. */

CREATE OR REPLACE FUNCTION gravar_matriculas() 
RETURNS trigger AS
	$$
    DECLARE rg_aluno record;
    BEGIN
    	FOR rg_aluno IN (select * from alunos)
        	LOOP
            	INSERT INTO matriculas(cd_matricula_ma,cd_aluno_al,cd_disciplina_di,dt_matricula_ma) VALUES((SELECT MAX(cd_matricula_ma)+1 FROM public.matriculas), rg_aluno.cd_aluno_al, NEW.cd_disciplina_di, current_timestamp);
          	END LOOP;
        RETURN NULL;
    END
    $$
  LANGUAGE plpgsql;

  CREATE OR REPLACE FUNCTION criar_logs_disciplinas() 
  RETURNS trigger AS
    $$
    BEGIN   
    	IF (OLD.nm_disciplina_di IS NOT null AND NEW.nm_disciplina_di IS null) OR (OLD.nm_disciplina_di IS null AND NEW.nm_disciplina_di IS NOT null) OR (OLD.nm_disciplina_di <> NEW.nm_disciplina_di) THEN
        	IF (TG_OP = 'INSERT') THEN
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'nm_disciplina_di', OLD.nm_disciplina_di, NEW.nm_disciplina_di, current_timestamp, current_user);
          	ELSIF (TG_OP = 'UPDATE') THEN
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'nm_disciplina_di', OLD.nm_disciplina_di, NEW.nm_disciplina_di, current_timestamp, current_user);
			ELSE
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'nm_disciplina_di', OLD.nm_disciplina_di, NEW.nm_disciplina_di, current_timestamp, current_user);
          	END IF;
      	END IF;
      
      	IF (OLD.cd_professor_pr IS NOT null AND NEW.cd_professor_pr IS null) OR (OLD.cd_professor_pr IS null AND NEW.cd_professor_pr IS NOT null) OR (OLD.cd_professor_pr <> NEW.cd_professor_pr) THEN
          	IF (TG_OP = 'INSERT') THEN
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('I', TG_TABLE_NAME, 'cd_professor_pr', OLD.cd_professor_pr, NEW.cd_professor_pr, current_timestamp, current_user);
          	ELSIF (TG_OP = 'UPDATE') THEN
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('A', TG_TABLE_NAME, 'cd_professor_pr', OLD.cd_professor_pr, NEW.cd_professor_pr, current_timestamp, current_user);
          	ELSE
        		INSERT INTO logs_usuarios(tp_operacao, nm_tabela_alterada, nm_campo_alterado, vl_antigo_campo_alterado, vl_atual_campo_alterado, dh_alteracao, nm_usuario) values ('D', TG_TABLE_NAME, 'cd_professor_pr', OLD.cd_professor_pr, NEW.cd_professor_pr, current_timestamp, current_user);
        	END IF;
      	END IF;
      
        RETURN NULL;
    END
    $$
  LANGUAGE plpgsql;

  CREATE TRIGGER criar_logs_disciplinas
  AFTER INSERT ON disciplinas
  FOR EACH ROW
  EXECUTE PROCEDURE criar_logs_disciplinas();

  CREATE TRIGGER gravar_matriculas
  AFTER INSERT ON disciplinas
  FOR EACH ROW
  EXECUTE PROCEDURE gravar_matriculas();
